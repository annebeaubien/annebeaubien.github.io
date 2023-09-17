# Instructions
- remove any sync duplicate files:
```
find . -name "* 2" -exec rm {} \;`
find . -name "* 2.*" -exec rm {} \;
```
- run `publish deploy`
