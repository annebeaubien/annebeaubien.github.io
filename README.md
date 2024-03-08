# Instructions

### To develop and test locally
- run `swift run publish-cli run`

### To update live website content
- remove any sync duplicate files:
```

for i in {1..10}; do find . -name "* $i" -exec rm -rf {} \; ; find . -name "* $i.*" -exec rm -rf {} \; ; done
```

- run `publish deploy`
