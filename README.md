Ozone that accumulates in the stratosphere creates a barrier from harmful UV light and
protects the globe. However, due to an increase in primary pollutants, ozone is also beginning to
acquire in the troposphere, becoming harmful to human health. According to the Environmental
Protection Agency, the National Ambient Air Quality Standard is 70 parts per billion (ppb).
Our(myself and Delaina Moore) goal was to create an interactive tool using Shiny in R with data collected via ozone monitoring
stations to communicate basic statistical trends we found in human health due to ozone exposure.The following site contains our application and allows users to interact with theapplication: https://ozonehealth.shinyapps.io/shine/ .

This tool also allows the user to visualize the data spatially and analyze particular sights that
are of interest. We primarily focused on ozone metrics relevant for short-term and long-term
human exposure: the 4th highest daily maximum 8-hour ozone MDA8 was over 70 ppb NVGT70
and average daily maximum 8-hour average ozone mixing ratios AVGDMA8EPAX. This data is
housed in the TOAR database: a comprehensive set of ozone data including standard statistics,
health and vegetation impact metrics, and trend information.

The folder, “shine”, contains the necessary files to run this R Shiny app. The whole folder must be placed in your R path. The data must be in the folder for the app to run.
After you have the folder and data, type the following command to run the app:
> runApp(‘shine’)
