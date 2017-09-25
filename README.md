# onvotar.garantiespelreferendum.com

Mirror de la web onvotar.garantiespelreferendum.com (ref1oct.eu y rederendum.cat)

El dump ha sido creado con la herramienta `wget` y los links convertidos automácticamente, por lo que es probable que pueda existir algo que no funcione completamente, aunque por ahora no lo he encontrado.

---

### Mirrors que funcionan

* https://rajoy-mariano.github.io/on-votar/index.html
* http://onvotar1oct.com/on-votar/
* https://onvotar.github.io/on-votar/

---

### Instrucciones para clonar la web (Linux)

1. Clonar el repositorio

git clone https://github.com/rajoy-mariano/referendum_cat_mirror.git

2. Instalar docker y docker-compose:

```
wget -qO- https://get.docker.com/ | sh
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

3. Arrancar la aplicación

```
cd referendum_cat_mirror
docker-compose up -d
```

La aplicacion estara disponible en http://[IP_Servidor] (puerto 80)
