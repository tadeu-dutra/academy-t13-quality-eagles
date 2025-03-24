# academy-t13-quality-eagles

This repository tracks the work done by the Quality Eagles squad during the TQC (Academy) program offered by QA Coders. It explores API Testing using Robot Framework.

## Prerequisites

### a) Ensure that Python is installed

To check if Python is installed, run the following command:

    python --version

If you are using Python 3, you may need to run:

    python3 --version

If you encounter an error message, it likely indicates that Python is not installed on your machine. In this case, please visit the [official Python website](https://www.python.org/downloads/) to download and install it, ensuring that you add it to your computer's PATH. After installation, rerun the command above to confirm that Python is now installed.

### b) Verify the installation of Robot Framework.

    robot --version

If you receive an error message indicating that the command is not recognized, you can easily install Robot Framework using pip with the following command:

    pip install robotframework

Another library you will need is the [Faker library](https://pypi.org/project/Faker/). To install it, please run the command below:

    pip install Faker

## Project Folder Structure

This project follows a structured folder layout to enhance modularity and maintainability.

`/libraries`: Contains custom Python libraries, including get_fake_company.py, get_fake_person.py, and utils.py, providing reusable utility functions for test scenarios.

`/resources`: Includes Robot Framework resource files such as company_keywords.robot, login_keywords.robot, and variables.robot, defining reusable keywords and variables for modular test design.

`/tests`: Houses test suite files, such as e2e.robot, containing end-to-end test cases for clear organization and management of testing scenarios.

`/results`: Stores logs and output from test executions, aiding in debugging and analysis. NOTE: It is a best practice not to version control the results folder, as it contains dynamically generated files that can be recreated at any time. To prevent the results folder from being included in version control, it has been added to the `.gitignore` file.

## Running the Tests

To execute the test suite, use the following command in your terminal:

    robot -d results tests/e2e.robot

### a) Command Breakdown

`robot`: This command runs the Robot Framework test suite.

`-d results`: This option specifies the directory (results) where the output files, including logs and reports, will be stored.

`tests/e2e.robot`: This specifies the path to the test suite file that you want to execute.

### b) Output

After running the command, you will find the following files in the results directory:

`output.xml`: A detailed log of the test execution.

`report.html`: A summary report of the test results.

`log.html`: A comprehensive log that includes additional details about the test execution.

### Running Tests with Tags

If you want to run tests that are marked with specific tags, you can use the `-i` option followed by the tag(s) you want to include. For example, to run tests tagged with `smoke`, use the following command:

    robot -d results -i smoke tests/e2e.robot

`-i smoke`: This option includes only the tests that are tagged with `smoke`. You can specify multiple tags by separating them with a comma (e.g., `-i smoke,regression`).

By using tags, you can selectively run portions of your test suite, making it easier to focus on specific scenarios or test types.
