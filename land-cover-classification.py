# Import and initialize the Google Earth Engine module
import ee
ee.Initialize()

# Define geometry objects: the wildlife corridor, a bounding box of the study area, and a training region for the clusterer
corridor = ee.Geometry.Polygon([])
bb = ee.Geometry.Polygon([])
region = ee.Geometry.Polygon([])

# Obtain Sentinel 1 imagery
collection = ee.ImageCollection('COPERNICUS/S1_GRD').filterBounds(bb).filterDate('2019-01-01', '2019-04-01').select('VV','VH')
collection_sorted = collection.sort('system:time_start', opt_ascending=None)

# Setup WekaKMean classifier
input = collection_sorted.first()
training = input.sample(region,10)
clusterer = ee.Clusterer.wekaKMeans(2).train(training)
result_raw = input.clip(bb).cluster(clusterer)
result = result_raw.reproject("EPSG:4326", None, 50)

# Compute percentage of cleared land in wildlife corridor
sum_1 = ee.Number(ee.Image(1).clip(corridor).updateMask(result.eq(0)).reduceRegion(ee.Reducer.sum(), corridor, 50, "EPSG:4326").get('constant'))
sum_2 = ee.Number(ee.Image(1).clip(corridor).updateMask(result.eq(1)).reduceRegion(ee.Reducer.sum(), corridor, 50, "EPSG:4326").get('constant'))
cleared = sum_1.multiply(sum_1.lt(sum_2)).add(sum_2.multiply(sum_2.lt(sum_1)))
area = ee.Number(ee.Image(1).reduceRegion(ee.Reducer.sum(), corridor, 50, "EPSG:4326").get('constant'))
final = cleared.divide(area.divide(100)).round()

# Print result to console
print(final.getInfo())
