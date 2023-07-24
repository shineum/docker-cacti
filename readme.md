# About this project
Set up cacti service in docker container

# Software Versions
| Software    | Version |
| -------- | ------- |
| MySQL  | 8.0.33    |
| PHP | 8.1     |
| Cacti    | 1.2.24    |
| Better Cacti Templates    | 1.1.8    |

# Install
### 1. Clone this project
```javascript
git clone https://github.com/shineum/docker-cacti.git
```

### 2. Start Docker
```javascript
docker compose up -d
```

### 3. Init db server for cacti service
```javascript
docker exec -it mysql4cacti /bin/bash docker-init-mysql.sh
```

### 4. Init web server for cacti service
```javascript
docker exec -it web4cacti /bin/bash docker-init-cacti.sh
```

### 5. Install cacti
#### 1) Open web browser navigate to this URL:
http://localhost:8081

#### 2) Login with initial credential:
admin / admin

#### 3) Set password

#### 4) Install cacti

### 6. Configuration
#### 1) Set spine:
Console > Configuration > Settings > Paths > Spine Config File Path
```
/usr/local/spine/etc/spine.conf
```

Console > Configuration > Settings > Poller > Poller Type
```
spine
```

#### 2) Update device
Console > Management > Devices > Local Linux Machine > Hostname
```
web-server
```