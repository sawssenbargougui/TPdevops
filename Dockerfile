### STAGE 1: Build ###
# Étape de construction basée sur Node.js
FROM node:12.7-alpine AS build

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers package.json et package-lock.json
COPY package.json package-lock.json ./

# Installer les dépendances
RUN npm install

# Copier tout le contenu du projet
COPY . .

# Construire l'application Angular
RUN npm run build

### STAGE 2: Run ###
# Étape d'exécution basée sur Nginx
FROM nginx:1.17.1-alpine

# Copier le fichier de configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copier les fichiers compilés depuis le stage "build"
COPY --from=build /usr/src/app/dist/aston-villa-app /usr/share/nginx/html

# Exposer le port 80 pour Nginx
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
