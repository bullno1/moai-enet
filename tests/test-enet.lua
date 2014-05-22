local hostA = enet.host_create("*:9000")
local hostB = enet.host_create("*:9001")

hostA:connect("127.0.0.1:9001", 2, 2)

local peerA, peerB

for i=1,10 do
	local event, peer, data = hostB:service()
	if event ~= nil then
		assert(event == "connect")
		assert(tostring(peer) == "127.0.0.1:9000")
		assert(data == 2)
		peerA = peer
	end
	local event, peer, data = hostA:service()
	if event ~= nil then
		assert(event == "connect")
		assert(tostring(peer) == "127.0.0.1:9001")
		peerB = peer
	end
end

peerA:send("testA", 1)
peerB:send("testB", 0)

for i=1,10 do
	local event, peer, data, channel = hostB:service()
	if event ~= nil then
		assert(event == "receive")
		assert(tostring(peer) == "127.0.0.1:9000")
		assert(data == "testB")
		assert(channel == 0)
	end
	local event, peer, data = hostA:service()
	if event ~= nil then
		assert(event == "receive")
		assert(tostring(peer) == "127.0.0.1:9001")
		assert(data == "testA")
		assert(channel == 1)
	end
end

peerA:disconnect(4)

for i=1,10 do
	local event, peer, data = hostB:service()
	if event ~= nil then
		assert(event == "disconnect")
		assert(tostring(peer) == "127.0.0.1:9000")
		assert(peer == peerA)
		assert(data == 0)
	end
	local event, peer, data = hostA:service()
	if event ~= nil then
		assert(event == "disconnect")
		assert(tostring(peer) == "127.0.0.1:9001")
		assert(peer == peerB)
		assert(data == 4)
	end
end

local hostC = enet.host_create("*:*")
local addr, port = hostC:socket_get_address()
assert(type(port) == "number")
assert(port ~= 0)

print "Passed!"
