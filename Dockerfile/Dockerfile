FROM node
RUN npm install -g express
RUN npm install -g express-generator
RUN git clone https://github.com/veeresh-org/productionteam.git
WORKDIR productionteam/nodewebsite/express-website/
RUN npm install
RUN npm install --save nodemailer
ENTRYPOINT npm start 
EXPOSE 3000

















