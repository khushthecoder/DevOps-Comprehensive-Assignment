FROM node:20-alpine
WORKDIR /app

RUN apk add --no-cache libc6-compat
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

COPY frontend/ ./frontend/
RUN cd frontend && npm run build

COPY backend/package*.json ./backend/
RUN cd backend && npm install

COPY backend/ ./backend/
RUN cp -r frontend/dist backend/public
EXPOSE 5000
CMD ["node", "backend/server.js"]