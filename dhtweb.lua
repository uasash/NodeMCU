pin = 4
sv = net.createServer(net.TCP, 30)
function receiver(sck, data)
  print(data)
  sck:close()
end
if sv then
  sv:listen(80, function(conn)
    conn:on("receive", function(client, request)
    status, temp, humi = dht.read11(pin)
     if status == dht.OK then
          msg = "DHT Temperature:"..temp.."<br>".."Humidity:"..humi
     elseif status == dht.ERROR_CHECKSUM then
          msg = "DHT Checksum error." 
     elseif status == dht.ERROR_TIMEOUT then
          msg = "DHT timed out."
     end 
        client:send(msg);
        client:close();
        collectgarbage();
     end)
   end)
end
