Ruby billing system (non-persistent data)
==

## Reporting

Generating reports is simple:

    report = Report.new
    report.total_revenue
    # => Gives the total revenue to the company for the reporting period

    report.total_bill('ACompany')
    # Gives the total bill for a specific revenue source, e.g. 'ACompany'
    # Substitute in any other reseller or affiliate name in the argument

    report.total_profit('ACompany')
    # Gives the total profit for a specific revenue source, e.g. 'ACompany'
    # Substitute in any other reseller or affiliate name in the argument

There are a few other methods that can be used to generate useful data, but they are not part of the description/requirements so they are not documented here.

At this time, there are no dates on orders, so the data being reported is based on 100 random orders. The code is easily setup to add reporting by date.

## Description / Requirements

We sell a widget in 3 ways:

1. Direct sale for $100 per item

2. Affiliates who resell our widget based on a tiered billing system. They pay us based on how many widgets they sell total:
* They sell 0-500 widgets in a month, $60 per widget
* They sell 501-1000 widgets in a month, $50 per widget
* They sell 1001+ widgets in a month, $40 per widget

We have the following Affiliates:
* ACompany – Sells the widget for $75/ea
* AnotherCompany – Sells the widget for $65/ea
* EvenMoreCompany – Sells the widget for $80/ea

3. Resellers who resell our widget based on a flat billing system. They pay us $50 per widget. We have the following Resellers:
* ResellThis – Sells the widget for $75
* SellMoreThings – Sells the widget for $85

All three groups can receive orders for this service. An order includes a quantity of widgets ordered, a method used, and an amount paid.

Build a class that generates 100 randomized orders for one month. These orders should be randomly assigned to each of the 6 possible types of sale, and should be for a random number of widgets between 1 and 100.

Build a service object that we can use to generate billing reports. This library needs to generate the following reports:
#1 Total amount we should bill each Affiliate and Reseller
#2 Profit earned by each Affiliate and Reseller
#3 Total revenue for the company from all sales: Affiliate, Reseller and Direct

This object needs to have a simple and documented interface that we can easily integrate with our existing systems.