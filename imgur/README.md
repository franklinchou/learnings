# Imgur image downloader

Download images from an imgur album

## Usage

1. Use the React developer tools (Components) to find the media container component (it should have contain the properties
of all the assets on the page regardless of whether the page has been fully loaded or not (imgur uses lazy loading))
2. Copy the component and paste to a text file (from the React developer tools select "Copy value to clipboard")
3. Run `main.py`

## TODO
- Eliminate manual reliance on the React developer tools (assuming there is a format that the imgur pages are laid out)
- Pass in variables as parameters
