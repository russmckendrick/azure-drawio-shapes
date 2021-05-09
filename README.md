# Azure Draw.io Shapes

To generate the shapes make sure you have the following installed:

``` bash
brew install svgo rename librsvg node
```

The grab the icons folder from the [Azure architecture icons page](https://docs.microsoft.com/en-us/azure/architecture/icons/), uncompress and copy the `Icons` folder to the same folder as the `process.sh` script then run it;

```bash
bash process.sh
```

All of the processed shapes will be in the `Shapes` folder.

This uses the `svg2mxlibrary` code from [https://github.com/yaegashi/icon-collection-mxlibrary](https://github.com/yaegashi/icon-collection-mxlibrary).