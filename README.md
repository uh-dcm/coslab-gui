# Graphical user interface for cross-service label agreement score

There are various image recognition tools, which label images based on their content.
However, these services often provide different number of labels for each image, and more critically, different labels.
For example, Google Vision and Microsoft Azure provide somewhat different labels for this image:

![Scene of a park](./docs/example_image.png)

| Google Vision      | Azure    |
|--------------------|----------|
|  Architecture      |  Bench   |
|  Asphalt           |  Bus     |
|  Building          |          |
|  **City**          | **City** |
|  Cloud             |  Empty   |
|  Daytime           |  Grass   |
|  Downtown          |  Green   |
|  Human Settlement  |  Hydrant |
|  Infrastructure    |          |
|  Lane              |          |
|  Metropolitan Area |          |
|  Neighbourhood     |          |
|  Nonbuilding       |          |
|  **Park**          | **Park** |
|  Plaza             |  Parked  |
|  Public Space      |  Red     |
|  Real Estate       |  Riding  |
|  Recreation        |          |
|  Residential Area  |          |
|  **Road**          | **Road** |
|  Road Surface      |  Side    |
|  Sidewalk          |  Sign    |
|  Sky               |  Sitting |
|  Skyline           |  Stop    |
|  **Street**        |  **Street** |
|  Structure         |  Tall    |
|  Suburb            |  Track   |
|  Thoroughfare      |  Traffic |
|  Town Square       |  Train   |
|  Tree              |  View    |
|  Urban Area        |  Yellow  |
|  Urban Design      | Outdoor  |
|  Walkway           |          |


There are some perfect matches, such as road, park and city,
but also some close calls where it appears that both services see a similar object, but just see articulate them differently.
For example, Google Vision sees a lane or a walkway, which are not that different from Azure's road and street.
And then there are labels where it is obvious that _interservice reliability_ - similar to intercoder reliability among human annotators - would be low:
Azure's bus and train do not a close counterpart in Google Vision labels.

[Berg & Nelimarkka (2023)](https://asistdl.onlinelibrary.wiley.com/doi/full/10.1002/asi.24827) developed the cross-service label agreement score (COSLAB) to evaluate the similarity across services to allow for more reliable use of image recognition tools in social science research.
The score uses natural language processing to measure how similarly two labels are used in written language (from 0-1) and  determines the best match for each label across other services.
Therefore, labels like cat and dog would have a higher COSLAB score than cat and car: there cat and dog appear more often together than cat and car.

### Recommended citation

If you use the cross-service label agreement scores, please cite:

> Berg, A., & Nelimarkka, M. (2023). Do you see what I see? Measuring the semantic differences in image‐recognition services’ outputs. In Journal of the Association for Information Science and Technology (Vol. 74, Issue 11, pp. 1307–1324). Wiley. https://doi.org/10.1002/asi.24827 

## Step-by-step user guide

Add images you wish to analyse either by dragging and dropping them to the user interface or through the "Add images" button.
When ready, click analyse images to move to the next step.
If you accidentally add images not meant for analysis, you can remove them through the trash icon.

![Initial screen with button add images](./docs/step1.png)

On Step 2, you need to choose image recognition services used for the analysis.
For the first time you use each service, you need to provide specific details to use these application programming interfaces, entered the boxes shown when the service is selected.
The system stores this information automatically.

![Selecting and configurating specific services](./docs/step2.png)

After clicking analyse images, the software **might become unresponsible** as data analysis is conducted.
Once ready, you are shown an overview of the results:
word clouds for labels on each service, a summary matrix showing how well services observed same themes, 1 indicating a perfect match and 0 indicating no match at all.
This is calculated using the cosine similarities per [Berg & Nelimarkka (2023)](https://asistdl.onlinelibrary.wiley.com/doi/full/10.1002/asi.24827).
You can also expert the word clouds and image labelling agreements for each service.

![Summary of outcomes and exporting](./docs/step3.png)

Exporting CSV or Excel files gives you access to service provided labels for each image.
In addition, it includes service indicated confidence score as well as our calculated COSLAB scores across services.
For example, in the column `coslab-aws` the current service, label -pair is contrasted with all labels provided by Amazon Web Services.

## Acknowledgements

Software developed by

* Leonardo Negri
* Anton Berg
* Matti Nelimarkka

Development funded by the [DARIAH-FI infrastructure](https://www.dariah.fi/), funding decision Research Council of Finland 35872 and C. V. Åkerlund foundation.

We uses following libraries: [coslab-core](https://github.com/uh-soco/coslab-core), PySide6, shoboken6, wordcloud, PyYAML, pandas and openpyxl.

## References

* [Berg, A., & Nelimarkka, M. (2023). Do you see what I see? Measuring the 
semantic differences in image‐recognition services' outputs. _Journal of 
the Association for Information Science and 
Technology._](https://asistdl.onlinelibrary.wiley.com/doi/full/10.1002/asi.24827)
* [Berg, A. & Nelimarkka, M., (2023). Is the World Different Depending on 
Whose AI Is Looking at It? Comparing Image Recognition Services for Social 
Science Research. _Information Matters_, 
3(8).](https://informationmatters.org/2023/08/is-the-world-different-depending-on-whose-ai-is-looking-at-it-comparing-image-recognition-services-for-social-science-research/) 
