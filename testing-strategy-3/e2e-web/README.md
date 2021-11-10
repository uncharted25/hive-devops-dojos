# Setup

## How to install

```bash
npm install
```

## How to open Cypress

```bash
npm run open
```

## Name of feature file

To take advantage of the local step, we will follow the recommended convention.
So we will rename the Feature file following the Camel case rule.

Before:

```
    subscription-webview.feature
```

After:

```
    SubscriptionWebview.feature
```

and the name of all feature files can't be the same. regardless of what directory they are in.
Having the same feature files name will fail Cypress Report on CI.

## Steps that doesn't exist anymore

### I open browser webview with configuration

See bellow for the example on how to do a webview test

### I wait around 30 seconds and should see element "aaa"

This one is replace by the default **I should see element "aaa"**

### I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute

This one is replaced by **I open the "/checkout?productCode=TIDPLUS" page**

## Steps that change their behavior

### I should see the value "value" in "id"

This one now will not work with input/textarea element like before due to
Cypress best practice (which is to avoid conditional testing). We decided to make separate steps.

for input element, use
```
    I should see the value {value} in {id} field
```

### I put the value "value" in the field "id"

This one is working as usual except if you want to put the empty string ("") in the field.

For putting empty string in the field, use
```
    I put nothing in the field {id}
```

## URL path

Before we was using a string has a local path.
Now we want to make it more clear by using the **/** character before.

Before:

```
    When I open the "subscriptions" page
```

After:

```
    When I open the "/subscriptions" page
```

## Convention on the ID

Change:

  - we need to add the caracter **#** before each ID
  - we need to escape some specials caracters: **[]**

Before:

```
    And I should see element "subscriptions_[TIDTVS]_exclusive"
```

After:

```
    And I should see element "#subscriptions_\[TIDTVS\]_exclusive"
```

## Checking Content

### Text Comparison

Change:
  - remove **\n** (New line) since it is considered as a string from Cypress .contains() function.

Before:

```
| AAA_0  | X Day | One time charge | ฿119 or\n119 TruePoints |
```

After:

```
| AAA_0  | X Day | One time charge | ฿119 or 119 TruePoints |
```

