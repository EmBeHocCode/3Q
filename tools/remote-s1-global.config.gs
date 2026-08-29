#game identity info
server.identity=4001
server.name=server_4001
server.channel=251

# server version,normVersion
server.version=1.2.0

#game server ip and port
net.server.port=8001
net.server.host=103.92.25.91

#http server ip and port
http.server.jetty.port=7001

# mysql databases connect info
# game user data
game.jdbcUrl=jdbc:mysql://127.0.0.1:3306/server_4001?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useServerPrepStmts=true&rewriteBatchedStatements=true&allowMultiQueries=true
game.username=root
game.password=root

static.bonecp.jdbcUrl=jdbc:mysql://127.0.0.1:3306/server_android_data?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useServerPrepStmts=true&rewriteBatchedStatements=true&allowMultiQueries=true
static.bonecp.username=root
static.bonecp.password=root

server.mergeServerIds=4001,3001
net.cross.server.port=14001
cross.server.address=103.92.25.91:20004
server.memory.size=4096
recharge.server.host=103.92.25.91
