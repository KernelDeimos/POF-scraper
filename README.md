# POF Scraper
This is a Google Chrome extension I made which scans profiles on the dating site PlentyOfFish and reports a "score" for each profile based on a hard-coded list of keywords.

This was built for my own personal use and it's very difficult to use. Later I plan to release a framework for building extensions similar to this one, and then a more general extension from scraping data from any website.

I have developed automatic message sending as well, but I haven't pushed it to this repository, as it would be easy to accidentally spam hundreds of profiles without knowing how it works.

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

