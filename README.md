Martins Home Assignment for Posti
==================================

Home Assignment Instructions
-------------
Please use Robot Framework to create a test automation script for the scenario below. It is up to you to decide what test approach and libraries are best to use. Expected outcome is a script that can be run and it should provide a meaningful test report.

Go to https://www.posti.fi/en and add stamps of your choosing to the cart. Validate that the total and delivery fees are calculated correctly, also after updating the cart with an additional product.

Upon checkout (without needing to buy, of course), check that the validation of a Finnish postal code works as expected (5 digits). 
Generate any necessary documentation, like test case and test report.




My Retrospective
-------------
As far as Home Assignment objectives are concerned, I was not sure how deep or which direction I should go. Expected results were based on the existing functionality in website itself so without other context (aside from Finnish invalid Postcodes which I let fail) I tried testing a variety of things that came to my mind. I didn't have a clear strategic vision for this project besides understanding the Robot Framework and how to use it. I did not succeed at making some tests stable as the mending the causes for flaky tests would take me more time, instead I added TODO comments and moved on. I also didn't completely optimize or properly structure everything. I had to ask myself, where do I stop? nevermind finding great examples of Robot Framework online to learn from.    



Preconditions
-------------
A precondition for running the tests is having `Robot Framework`_ and
SeleniumLibrary_ installed, and they in turn require
Python_. Robot Framework `installation instructions`__ cover both
Robot and Python installations, and SeleniumLibrary has its own
`installation instructions`__.

__ https://github.com/robotframework/robotframework/blob/master/INSTALL.rst
__ https://github.com/robotframework/SeleniumLibrary#installation

Running tests
-------------
Test Cases are located in 'tests' folder. You can run them from root or individually. To run all of them, try using:
    robot --outputdir results/ tests/

This will also generate report and log in 'Result' folder.
Limited number of variables, including the browser, are stored in resources\common_resources.robot. Just note that this has only been tested on Chrome.


Reporting
--------------
There is no pipeline or script built in but there is a library to generate more attractive reports based on the last results. Try using this command
    robotmetrics --inputpath ./result/ --output output.xml

TO DO
--------------
Lots if I want to make it more solid. A lot of TODO's I have left as comments but also there is need for optimization, stability, formating and so on. Would need to refactor and work more on this before I would consider this in a good usable form.

Known issues
--------------
A few. Some failures in cart_calculations_test.robot and customer_journey_test.robot may occur because of how cart updates incosistently. Waiting for spinner icon and waiting for it to disappear works only half the time but numbers are not present before that so if improving will need to use something else to wait for.
Some Finnish invalid postcodes will fail as they are officially invalid but Front End validates only if NNNNN is added - decided to leave it.
