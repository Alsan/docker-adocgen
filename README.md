# docker-adocgen

This project aimed to build a docker image which can automate the process of Asciidoc file generation.

## Usage

```bash
docker run -d --rm --name adocgen -p 8080:8080 -v $(pwd):/documents adocgen
```
