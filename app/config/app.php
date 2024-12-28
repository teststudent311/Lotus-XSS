<?php

// Checks if .env file is created
if (!file_exists(__DIR__ . '/../../.env')) {
    throw new Exception('You did not setup your config file yet.');
}

// Parse config data
$config = parse_ini_file(__DIR__ . '/../../.env');

// Checks if config file is valid
if ($config === false) {
    throw new Exception('There is something wrong with your config file.');
}

// Debug modus will show and report any kind of errors, do not enable this unless you are debugging something
define('debug', $config['debug'] ?? '' === 'true' || $config['debug'] ?? '' === '1' ? true : false);

<<<<<<< HEAD
// Defines whenever httpmode is enabled, this allows ezXSS panel to be used without SSL
define('httpmode', $config['httpmode'] ?? '' === 'true' || $config['httpmode'] ?? '' === '1' ? true : false);
||||||| merged common ancestors
// Defines whenever httpmode is enabled, this allows ezXSS panel to be used without SSL
define('httpmode', false);
=======
// Defines whenever httpmode is enabled, this allows LotusXSS panel to be used without SSL
define('httpmode', false);
>>>>>>> master

<<<<<<< HEAD
// Defines whenever sign up is enabled, do not enable this unless you are serving a public ezXSS installation - this allows anyone to register!
define('signupEnabled', $config['signupEnabled'] ?? '' === 'true' || $config['signupEnabled'] ?? '' === '1' ? true : false);
||||||| merged common ancestors
// Defines whenever sign up is enabled, do not enable this unless you are serving a public ezXSS installation - this allows anyone to register!
define('signupEnabled', false);
=======
// Defines whenever sign up is enabled, do not enable this unless you are serving a public LotusXSS installation - this allows anyone to register!
define('signupEnabled', false);
>>>>>>> master

<<<<<<< HEAD
// Current ezXSS version. Do not edit this
define('version', '4.2');
||||||| merged common ancestors
// Current ezXSS version. Do not edit this
define('version', '4.1');
=======
// Current LotusXSS version. Do not edit this
define('version', '4.1');
>>>>>>> master

// Defines the current host
define('host', e($_SERVER['HTTP_HOST']));

// Defines the current url
define('url', e("//{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}"));

// Defines the current path
define('path', e($_SERVER['REQUEST_URI'] ?? '/'));

// Defines the IP of the user
define('userip', $_SERVER['REMOTE_ADDR']);

// Defines the current protocol
define('ishttps', (isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] === 'on' || $_SERVER['HTTPS'] === '1') || isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https'));