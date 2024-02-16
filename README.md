# Instructions

### To develop and test locally
- run `swift run publish-cli run`

### To update live website content
- remove any sync duplicate files:
```
find . -name "* 2" -exec rm {} \;
find . -name "* 2.*" -exec rm {} \;
```

- run `publish deploy`
