# Instala Apache, MySQL y PHP
package 'apache2'
package 'mysql-server'
package 'php'
package 'libapache2-mod-php'
package 'php-mysql'

# Habilita e inicia Apache
service 'apache2' do
  action [:enable, :start]
end

# Crea un archivo index.php
file '/var/www/html/index.php' do
  content "<?php phpinfo(); ?>"
  mode '0644'
  owner 'www-data'
  group 'www-data'
end
