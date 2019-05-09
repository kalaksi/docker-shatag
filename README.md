
## Resources
- [Docker Hub repository](https://registry.hub.docker.com/u/kalaksi/shatag/)
- [GitHub repository](https://github.com/kalaksi/docker-shatag)
- [shatag documentation](https://bitbucket.org/maugier/shatag)

## What is this container for?
This container contains ```shatag``` which is a tool for file checksumming (see shatag documentation).  
The ```docker-compose.yml``` contains an example of running ```shatagd``` for file monitoring and ```shatag``` for checksum verification.  

## Why use this container?
**Simply put, this container has been written with simplicity and security in mind.**

Surprisingly, _many_ community containers run unnecessarily with root privileges by default and don't provide help for dropping unneeded CAPabilities either.
Additionally, overly complex shell scripts and unofficial base images make it harder to verify the source.  

To remedy the situation, these images have been written with security and simplicity in mind.  

|Requirement              |Status|Details|
|-------------------------|:----:|-------|
|Don't run as root        |✅    | Never run as root unless necessary.|
|Official base image      |✅    | |
|Drop extra CAPabilities  |✅    | See ```docker-compose.yml```. |
|No default passwords     |—      | Not applicable. |
|Support secrets-files    |—     | Not applicable. |
|Handle signals properly  |✅    | |
|Simple Dockerfile        |✅    | Keep everything in the Dockerfile if reasonable.|
|Versioned tags           |✅    | Offer versioned tags for stability.|

## Supported tags
See the ```Tags``` tab on Docker Hub for specifics. Basically you have:
- The default ```latest``` tag that always has the latest changes.
- Minor versioned tags (following Semantic Versioning). Version ```1.0``` would follow branch ```1.0.x``` on GitHub.

## Configuration
You have these environment variables:
- ```SHATAGD_OPTIONS``` for modifying runtime arguments of shatagd.  
- ```SHATAG_OPTIONS``` for modifying runtime arguments of shatag.  
  
See ```Dockerfile``` and ```docker-compose.yml``` (<https://github.com/kalaksi/docker-shatag>) for more details.  

## Development

### Contributing
See the repository on <https://github.com/kalaksi/docker-shatag>.
All kinds of contributions are welcome!

## License
View [license information](https://github.com/kalaksi/docker-shatag/blob/master/LICENSE) for the software contained in this image.  
As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).  
  
As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
