# Prepare dev environment

- install lightouse
```
  npm install -g lhci-cli
```


# Pre-Acquisition
```
chmod -R u=rwX,g=rX,o= scripts

./scripts/setup-node.sh ## Setup the Node if it exists, skip this step.

./scripts/install.sh ## Install package.json
```


# Example of User story and Acceptance Criteria
### User Story PALO-0001: As a palo user, I want to login the PALO system so that I can become the logged in user.

#### Acceptance Criteria
| Given         |          When |          Then |
| ------------- | ------------- | ------------- |
| I land on the Login page | I type the correct username and password  | I can see the "Logged in!" text on screen
| I land on the Login page  | I type the wrong username or password    | I can see the "Please verify your credentials." text on screen

