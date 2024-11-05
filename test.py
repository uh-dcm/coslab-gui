from coslab import aws
from coslab import googlecloud
from coslab import azure_vision
from coslab import taggerresults
from coslab import tag_comparator

## establishing a container for all results
results = taggerresults.TaggerResults()

## establish classifiers

img = "test images/polar bear.jpg"

amazon = aws.AWS(api_id="", api_key="", api_region="")
google = googlecloud.GoogleCloud(service_account_info="")
azure = azure_vision.Azure(subscription_key="", endpoint="")

amazon.process_local( results, img)
google.process_local( results, img)
azure.process_local( results, img)

results.export_pickle("image.bear")

tag_comparator.compare_data( results )