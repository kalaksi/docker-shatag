
## Resources
- [Docker Hub repository](https://hub.docker.com/r/kalaksi/shatag/)
- [GitHub repository](https://github.com/kalaksi/docker-shatag)
- [shatag documentation](https://bitbucket.org/maugier/shatag)

## What is this container for?
This container contains ```shatag``` which is a tool for file checksumming (see shatag documentation).  
By default, the filesystem's extended attributes are used for storing the hashes (available in modern filesystems, such as ext4).
This allows the information to be stored alongside the file. When copying the files you'll want to make sure that extended attrs also get copied.

The ```docker-compose.yml``` contains an example of running ```shatagd``` for file monitoring and ```shatag``` for checksum verification.  

## Why use this container?
**Simply put, this container has been written with simplicity and security in mind.**

Surprisingly, _many_ community containers run unnecessarily with root privileges by default and don't provide help for dropping unneeded CAPabilities either.
Additionally, overly complex shell scripts and unofficial base images make it harder to verify the source.  

To remedy the situation, these images have been written with security, simplicity and overall quality in mind.

|Requirement              |Status|Details|
|-------------------------|:----:|-------|
|Don't run as root        |✅    | Never run as root unless necessary.|
|Official base image      |✅    | |
|Drop extra CAPabilities  |✅    | See ```docker-compose.yml```. |
|No default passwords     |✅    | No static default passwords. That would make the container insecure by default. |
|Support secrets-files    |✅    | Support providing e.g. passwords via files instead of environment variables. |
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
Copyright (c) 2018 kalaksi@users.noreply.github.com. See [LICENSE](https://github.com/kalaksi/docker-shatag/blob/master/LICENSE) for license information.  

As with all Docker images, the built image likely also contains other software which may be under other licenses (such as software from the base distribution, along with any direct or indirect dependencies of the primary software being contained).  
  
As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

