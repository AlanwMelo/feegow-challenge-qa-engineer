# Automated tests for the site www.aminhaclinica.com.br

## Description

Project with automations to perform regression testing on the website www.aminhaclinica.com.br

## Objective

The goal of this project is to ensure that changes in the site code will not cause any kind of unwanted behavior in its existing funcionalities. At the moment the following test cases are part of the project:
- Appointment Scheduling
- Appointment Canceling

## Requirements

- Python 3 or above (https://www.python.org/downloads/)

## How to install

1. **Clone the repository:**
    ```sh
    git clone https://github.com/AlanwMelo/feegow-challenge-qa-engineer.git
    ```

2. **Create and activate a virtual environment before installing the project's dependencies:**
    ```sh
    python3 -m venv myenv
    source myenv/bin/activate
    ```

3. **Install the following required dependencies:**
    ```sh
    pip install selenium
    pip install robotframework
    pip install robotframework-seleniumlibrary
    pip install robotframework-requests
    ```

## Run

- To run this project just use the following command on your CMD:
    ```sh
    robot ./2.automation-tests/alan/agendamento_cancelamento.robot
    ```

- Arguments can be passed to the robot in the following way
    ```sh
    robot --variable CHROME_OPTIONS:"add_argument('--headless') ./2.automation-tests/alan/agendamento_cancelamento.robot
    ```

## Orientations

- **Contributions**: Changes made to this project will only be aproved if the testing pipeline concludes with success after the change.
- **Questions**: In case of any questions, please contact any of our team members: contato@equipe.com