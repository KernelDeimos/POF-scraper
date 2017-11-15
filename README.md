# POF Scraper

## Setup
### Step 1: Config
In order to setup the extension, you'll need to build the source code
with your own custom configuration file.

Create a file of the following format and place it inside
`extension/src/config.coffee`

```
config.wlist_good = {
    # Good words
    "tea": 2
    "coffee": 1
    "netflix": 2
    "reddit": 2
}
config.cities = {
    "toronto": 3
}
config.fishtypes = {
    "techie": 2
    "gamer": 2
}
```

### Step 2: Build
Run `./build.sh`.

### Step 3: Add to Chrome
Go to the extensions page, put yourself in develop mode, and add the
`extension` folder from this repo as an extension.

## Usage
Ask Eric.

