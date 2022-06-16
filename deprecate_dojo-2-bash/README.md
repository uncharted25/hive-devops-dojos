# Dojo 2

You need to have already finished with success the Dojo 1 to do this one.

During previous exercise we saw how painful can be a code that do no follow code convention.
The goal here will be to normalize the feature files, exactly like eslint for Javascript, but here for our own Cucumber project.

We will have two rules:
  - do not allow *@skip* in top of a Feature keyword
  - all annotation should be in 1 line

## Part 1: validation

Display all feature file that contains a wrong format, and display the error.

If an error is detected, the script should failed. If it's all good, the script should exit with a success code.

## Part 2: auto format

Add an option at the end of the first, when error are detected, to do a auto-format of the existing file if user accept.

Here the rules:
  - remove *@skip* that are in top of file to move it before all scenarios
  - move all annotations into 1 line
  - we do not accept duplicate annotation in top of the same Scenario
