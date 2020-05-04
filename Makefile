LIB_PATH="/usr/local/lua/crowdsec/"
NGINX_CONF_DIR="/etc/nginx/conf.d/"
CROWDSEC_CONF="crowdsec.conf"
NGINX_CONF="crowdsec_nginx.conf"

default: install
install: 
	@bash ./requirement.sh
	@mkdir -p $(LIB_PATH)
	@cp lib/*.lua $(LIB_PATH)
	@cp template.conf $(LIB_PATH)/$(CROWDSEC_CONF)

nginx: install
	@bash ./requirement.sh nginx
	@cp nginx/$(NGINX_CONF) $(NGINX_CONF_DIR)/$(NGINX_CONF)
	@cp nginx/access.lua $(LIB_PATH)
	
uninstall:
	@rm -rf $(LIB_PATH)
	@rm -f $(NGINX_CONF_DIR)/$(NGINX_CONF)