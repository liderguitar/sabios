-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 17-04-2015 a las 23:02:01
-- Versión del servidor: 5.5.41-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sabios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerta_emails`
--

CREATE TABLE IF NOT EXISTS `alerta_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) NOT NULL,
  `email1` varchar(100) NOT NULL,
  `email2` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `alerta_emails`
--

INSERT INTO `alerta_emails` (`id`, `app_id`, `email1`, `email2`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'liderguitar@gmail.com', 'pepito@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `application`
--

CREATE TABLE IF NOT EXISTS `application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) DEFAULT NULL,
  `nombre` varchar(200) NOT NULL,
  `template` varchar(200) NOT NULL,
  `estado` enum('ONLINE','OFFLINE') NOT NULL,
  `publicFolder` varchar(250) DEFAULT NULL,
  `subdominio` varchar(100) DEFAULT NULL,
  `app_secret` varchar(100) DEFAULT NULL,
  `auth_token` varchar(250) DEFAULT NULL,
  `auth_token_expires` datetime DEFAULT NULL,
  `tipo_actividad` varchar(250) NOT NULL,
  `web` varchar(250) NOT NULL,
  `responsable_nombre` varchar(250) NOT NULL,
  `responsable_email` varchar(250) NOT NULL,
  `responsable_telefono` varchar(250) NOT NULL,
  `responsable_direccion` varchar(250) NOT NULL,
  `logo` varchar(250) NOT NULL,
  `email2` varchar(250) DEFAULT NULL,
  `email3` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`subdominio`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `application`
--

INSERT INTO `application` (`id`, `app_id`, `nombre`, `template`, `estado`, `publicFolder`, `subdominio`, `app_secret`, `auth_token`, `auth_token_expires`, `tipo_actividad`, `web`, `responsable_nombre`, `responsable_email`, `responsable_telefono`, `responsable_direccion`, `logo`, `email2`, `email3`) VALUES
(1, '04f50f7dfc94e524e2fc6ce675663c1d', 'MottaCo', 'admin', 'ONLINE', '', 'motta', '11d54b904e378009ce0b009cd7041a15', 'MTI3LjAuMC4xMjAxMzEyMDIxODQ3NDg=', '2013-12-02 18:47:48', '', '', '', '', '', '', '', NULL, NULL),
(2, '221f67098b91c66830d0ec9b9305f510', 'Artesanias', 'admin', 'ONLINE', '', 'artesanias', 'd4b426ca4bd99cd61ebfbabd04ae7d4f', NULL, NULL, '', '', '', '', '', '', '', NULL, NULL),
(3, '04f50f7dfc94e524e2fc6ce675663c1d', 'API', 'admin', 'ONLINE', '', 'api', NULL, NULL, NULL, '', '', '', '', '', '', '', NULL, NULL),
(4, 'home', 'Sabbios', '', 'ONLINE', NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', '', 'logo.png', NULL, NULL),
(6, '36dd07ce38b167636f2b1fe96bb44ee6', 'pepito', '', 'ONLINE', NULL, 'pepito', NULL, NULL, NULL, 'Sabios Textil y Calzado', 'www.pepito.com', 'gustavo', 'pepito@gmail.com', '456456456', 'lkdflgkdfg', 'logo.png', NULL, NULL),
(7, 'c96bd135ae37d6153418d5dd766f9d70', 'GanjaStore', '', 'ONLINE', NULL, 'GanjaStore', NULL, NULL, NULL, 'Sabios Textil y Calzado', 'www.popo.com', 'pepe', 'lider@sdfsd.com', '23423423423', 'cuchacuca 456', '', NULL, NULL),
(10, 'f50863d2cc199ac104dbdf601b5bd3fd', 'charuto', '', 'ONLINE', NULL, 'charuto', NULL, NULL, NULL, 'Sabios Textil y Calzado', 'www.charuto.com', '', 'lider@dgf.com', '', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE IF NOT EXISTS `articulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` text NOT NULL,
  `subtitulo` text NOT NULL,
  `contenido` text NOT NULL,
  `urlCode` varchar(250) NOT NULL,
  `peso` int(11) NOT NULL,
  `desde` datetime DEFAULT NULL,
  `hasta` datetime DEFAULT NULL,
  `postId` int(11) NOT NULL,
  `categoriaId` int(11) NOT NULL,
  `foto` varchar(250) DEFAULT NULL,
  `link` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `postId` (`postId`),
  KEY `categoriaId` (`categoriaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE IF NOT EXISTS `auditoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `entidad` varchar(50) DEFAULT NULL,
  `id_entidad` int(11) DEFAULT NULL,
  `operacion` varchar(10) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `data_new` text,
  `data_old` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=171 ;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id`, `app_id`, `id_usuario`, `entidad`, `id_entidad`, `operacion`, `fecha`, `data_new`, `data_old`) VALUES
(1, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 1, 'delete', '2013-10-30 18:43:44', NULL, NULL),
(2, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 1, 'put', '2013-10-30 18:53:23', NULL, NULL),
(3, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 1, 'put', '2013-10-30 18:53:42', NULL, NULL),
(4, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 1, 'put', '2013-10-30 18:55:53', NULL, NULL),
(5, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 1, 'put', '2013-10-30 18:56:09', NULL, NULL),
(6, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 1, 'put', '2013-10-30 18:56:19', NULL, NULL),
(7, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 6, 'post', '2013-10-30 19:01:37', NULL, NULL),
(8, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 6, 'put', '2013-10-30 19:12:50', '{"controller":"categoria","action":"put","id":"6","module":"default","nombre":"AncianosCC","prioridad":"6"}', '{"id":"6","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre":"AncianosCC","prioridad":"6","borrado":"N"}'),
(9, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'categoria', 6, 'put', '2013-10-30 19:14:26', '{"controller":"categoria","action":"put","id":"6","module":"default","nombre":"AncianosDD","prioridad":"10"}', '{"id":"6","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre":"AncianosCC","prioridad":"6","borrado":"N"}'),
(10, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'subcategoria', 2, 'delete', '2013-11-01 13:35:55', '[]', '[]'),
(11, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'subcategoria', 2, 'put', '2013-11-01 13:50:52', '{"id":"2","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","categoriaId":"1","nombre":"Remera mangas cortas","prioridad":"1","borrado":"N"}', '{"id":"2","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","categoriaId":"1","nombre":"Remera mangas cortas","prioridad":"1","borrado":"N"}'),
(12, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'subcategoria', 5, 'post', '2013-11-01 14:11:40', '[]', '[]'),
(13, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cargo', 1, 'delete', '2013-11-06 15:23:37', '[]', '[]'),
(14, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cargo', 1, 'put', '2013-11-06 15:29:46', '{"id":"1","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre":"vendedor","borrado":"N"}', '{"id":"1","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre":"Abogado","borrado":"N"}'),
(15, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cargo', 2, 'post', '2013-11-06 15:30:41', '[]', '[]'),
(16, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'personal', NULL, 'post', '2013-11-06 15:53:32', '[]', '[]'),
(17, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'personal', 1, 'post', '2013-11-06 15:53:59', '[]', '[]'),
(18, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', NULL, 'post', '2013-11-06 16:40:56', '[]', '[]'),
(19, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', NULL, 'post', '2013-11-06 16:42:26', '[]', '[]'),
(20, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 3, 'post', '2013-11-06 16:43:48', '[]', '[]'),
(21, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 4, 'post', '2013-11-06 17:34:26', '[]', '[]'),
(22, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 5, 'post', '2013-11-06 17:34:51', '[]', '[]'),
(23, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 6, 'post', '2013-11-06 17:37:04', '[]', '[]'),
(24, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'post', '2013-11-06 19:36:59', '[]', '[]'),
(25, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 14:57:08', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(26, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 14:57:28', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(27, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 14:58:07', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(28, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 14:58:27', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(29, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 14:58:56', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(30, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:04:14', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(31, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:05:49', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(32, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:06:25', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(33, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:09:14', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(34, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:09:34', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(35, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:19:11', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(36, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:19:37', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(37, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:30:50', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(38, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:33:31', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(39, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:45:45', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(40, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:47:03', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(41, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:53:23', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(42, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:53:40', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(43, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:57:02', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(44, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:57:54', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(45, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 15:58:14', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(46, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:07:12', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(47, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:08:24', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(48, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:08:52', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(49, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:09:31', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(50, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:09:48', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(51, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:12:33', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(52, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:14:01', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}'),
(53, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 16:16:57', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"controller":"cliente","action":"put","id":"7","module":"default","nombre":"JoseJuarez","tipo_cliente_id":"1","telefono1":"351989836","telefono2":"351989836","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","estado_id":"0","personal":{"1":{"id":"6","nombre":"JoseJuarez33","apodo":"pepe","telefono":"351989836","email":"dsdf@dfdf.com","movil":"3157837434","fecha_nacimiento":"1972-09-12","cargo_id":"1","observaciones":"observado"},"2":{"id":"8","nombre":"JoseJuarez44","apodo":"pepe","telefono":"351989836","email":"dsdf@dfdf.com","movil":"3157837434","fecha_nacimiento":"1972-09-12","cargo_id":"1","observaciones":"observado"}},"sucursal":{"1":{"id":"1","numero":"1","direccion":"cucha cucha 23","encargados":"pepe, juan","telefono1":"23423423","telefono2":"45345345","id_provincia":"147","localidad":"Cordoba","observaciones":"obs1"},"2":{"numero":"2","direccion":"cucha cucha 23","encargados":"pepe, juan","telefono1":"23423423","telefono2":"45345345","id_provincia":"147","localidad":"Cordoba","observaciones":"obs1"}}}'),
(54, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'cliente', 7, 'put', '2013-11-11 17:02:43', '{"id":"7","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","nombre_comercial":"JoseJuarez","tipo":"1","telefono1":"351989836","telefono2":"351989836","usuario_id":"999","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","borrado":"N","estado_id":"0"}', '{"controller":"cliente","action":"put","id":"7","module":"default","nombre":"JoseJuarez","tipo_cliente_id":"1","telefono1":"351989836","telefono2":"351989836","sms1":"87687687","sms2":"87687687","sms3":"87687687","email1":"dsdf@dfdf.com","email2":"dsdf@dfdf.com","email3":"dsdf@dfdf.com","empresa_de_preferencia":"pepecompany","asegurado":"1","direccion_de_envio":"cuchacucha455","enviar_a_nombre_de":"peperomero","razon_social":"pepecompany","tipo_contribucion":"ConsumidorFinal","cuit":"20227929899","provincia_id":"147","localidad":"salsipuedes","muestra_precio":"SI","aplica_iva":"NO","habilita_acceso_pedidos":"NO","estado_id":"0","personal":{"1":{"id":"6","nombre":"pepe meolans","apodo":"pepe","telefono":"351989836","email":"dsdf@dfdf.com","movil":"3157837434","fecha_nacimiento":"1972-09-12","cargo_id":"1","observaciones":"observado"},"2":{"id":"8","nombre":"jose carlos ayi","apodo":"pepe","telefono":"351989836","email":"dsdf@dfdf.com","movil":"3157837434","fecha_nacimiento":"1972-09-12","cargo_id":"1","observaciones":"observado"}},"sucursal":{"1":{"id":"1","numero":"1","direccion":"cucha cucha 23","encargados":"pepe, juan","telefono1":"23423423","telefono2":"45345345","id_provincia":"147","localidad":"Cordoba","observaciones":"obs1"},"2":{"numero":"2","direccion":"cucha cucha 23","encargados":"pepe, juan","telefono1":"23423423","telefono2":"45345345","id_provincia":"147","localidad":"Cordoba","observaciones":"obs1"}}}'),
(55, NULL, 999, 'productotextil', 0, 'post', '2013-11-11 19:42:29', '[]', '[]'),
(56, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'productotextil', 1, 'delete', '2013-11-11 20:07:19', '[]', '[]'),
(57, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'pedido', 0, 'post', '2013-11-11 21:12:41', '[]', '[]'),
(58, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'pedido', 0, 'post', '2013-11-11 21:17:07', '[]', '[]'),
(59, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'pedido', 0, 'post', '2013-11-11 21:21:27', '[]', '[]'),
(60, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'pedido', 0, 'post', '2013-11-11 21:24:36', '[]', '[]'),
(61, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'vendedor', 1, 'delete', '2013-11-13 20:43:32', '[]', '[]'),
(62, '04f50f7dfc94e524e2fc6ce675663c1d', 999, 'vendedor', 1, 'put', '2013-11-13 20:46:12', '{"id":"1","nombre":"jose sanfilipo","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","id_usuario":"1234","borrado":"N"}', '{"id":"1","nombre":"Pepe Juares","app_id":"04f50f7dfc94e524e2fc6ce675663c1d","id_usuario":"1234","borrado":"N"}'),
(63, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 17:31:26', '[]', '[]'),
(64, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 17:33:31', '[]', '[]'),
(65, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 18:10:08', '[]', '[]'),
(66, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 18:11:10', '[]', '[]'),
(67, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 12, 'post', '2013-11-27 18:11:28', '[]', '[]'),
(68, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 19:55:18', '[]', '[]'),
(69, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 19:57:06', '[]', '[]'),
(70, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-27 19:57:31', '[]', '[]'),
(71, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:25:09', '[]', '[]'),
(72, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:26:21', '[]', '[]'),
(73, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:27:59', '[]', '[]'),
(74, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:29:43', '[]', '[]'),
(75, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:30:47', '[]', '[]'),
(76, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:33:02', '[]', '[]'),
(77, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', NULL, 'post', '2013-11-28 16:33:35', '[]', '[]'),
(78, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 28, 'post', '2013-11-28 17:02:05', '[]', '[]'),
(79, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 29, 'post', '2013-11-28 17:03:23', '[]', '[]'),
(80, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 30, 'post', '2013-11-28 17:05:43', '[]', '[]'),
(81, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 31, 'post', '2013-11-28 17:07:31', '[]', '[]'),
(82, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 32, 'post', '2013-11-28 17:07:58', '[]', '[]'),
(83, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 33, 'post', '2013-11-28 17:13:39', '[]', '[]');
INSERT INTO `auditoria` (`id`, `app_id`, `id_usuario`, `entidad`, `id_entidad`, `operacion`, `fecha`, `data_new`, `data_old`) VALUES
(84, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 34, 'post', '2013-11-28 17:14:33', '[]', '[]'),
(85, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 35, 'post', '2013-11-28 17:14:33', '[]', '[]'),
(86, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 36, 'post', '2013-11-28 17:14:33', '[]', '[]'),
(87, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 37, 'post', '2013-11-28 17:14:33', '[]', '[]'),
(88, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 38, 'post', '2013-11-28 17:14:34', '[]', '[]'),
(89, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 39, 'post', '2013-11-28 17:14:48', '[]', '[]'),
(90, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 40, 'post', '2013-11-28 17:15:06', '[]', '[]'),
(91, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 41, 'post', '2013-11-28 17:15:43', '[]', '[]'),
(92, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 42, 'post', '2013-11-28 17:19:09', '[]', '[]'),
(93, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 43, 'post', '2013-11-28 17:19:55', '[]', '[]'),
(94, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 44, 'post', '2013-11-28 17:21:22', '[]', '[]'),
(95, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 45, 'post', '2013-11-28 17:31:37', '[]', '[]'),
(96, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 46, 'post', '2013-11-28 17:34:02', '[]', '[]'),
(97, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 47, 'post', '2013-11-28 17:37:52', '[]', '[]'),
(98, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 48, 'post', '2013-11-28 17:40:45', '[]', '[]'),
(99, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 49, 'post', '2013-11-28 17:41:24', '[]', '[]'),
(100, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 50, 'post', '2013-11-28 17:42:02', '[]', '[]'),
(101, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 51, 'post', '2013-11-28 17:42:37', '[]', '[]'),
(102, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 52, 'post', '2013-11-28 17:43:12', '[]', '[]'),
(103, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 53, 'post', '2013-11-28 18:04:24', '[]', '[]'),
(104, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 54, 'post', '2013-11-28 18:05:32', '[]', '[]'),
(105, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 55, 'post', '2013-11-28 18:07:03', '[]', '[]'),
(106, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 56, 'post', '2013-11-28 18:09:04', '[]', '[]'),
(107, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 57, 'post', '2013-11-28 18:15:16', '[]', '[]'),
(108, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 58, 'post', '2013-11-28 18:16:11', '[]', '[]'),
(109, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 59, 'post', '2013-11-28 18:19:16', '[]', '[]'),
(110, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 63, 'post', '2013-11-28 18:32:39', '[]', '[]'),
(111, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 65, 'post', '2013-11-28 18:34:37', '[]', '[]'),
(112, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 66, 'post', '2013-11-28 18:38:10', '[]', '[]'),
(113, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 67, 'post', '2013-11-28 18:39:33', '[]', '[]'),
(114, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 68, 'post', '2013-11-28 18:39:52', '[]', '[]'),
(115, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 69, 'post', '2013-11-28 18:40:59', '[]', '[]'),
(116, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 70, 'post', '2013-11-28 18:41:27', '[]', '[]'),
(117, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 71, 'post', '2013-11-28 18:41:46', '[]', '[]'),
(118, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 72, 'post', '2013-11-28 18:42:39', '[]', '[]'),
(119, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 73, 'post', '2013-11-28 18:43:19', '[]', '[]'),
(120, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 74, 'post', '2013-11-28 18:44:53', '[]', '[]'),
(121, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 75, 'post', '2013-11-28 18:45:45', '[]', '[]'),
(122, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 76, 'post', '2013-11-28 18:46:10', '[]', '[]'),
(123, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 77, 'post', '2013-11-28 18:49:01', '[]', '[]'),
(124, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 78, 'post', '2013-11-28 18:49:50', '[]', '[]'),
(125, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 79, 'post', '2013-11-28 18:51:27', '[]', '[]'),
(126, '04f50f7dfc94e524e2fc6ce675663c1d', 0, 'cliente', 82, 'post', '2013-12-02 17:53:23', '[]', '[]'),
(127, '36dd07ce38b167636f2b1fe96bb44ee6', NULL, 'cliente', 83, 'add', '2014-03-12 09:15:47', '[]', '[]'),
(128, '36dd07ce38b167636f2b1fe96bb44ee6', NULL, 'cliente', 84, 'add', '2014-03-12 09:17:29', '[]', '[]'),
(129, '36dd07ce38b167636f2b1fe96bb44ee6', NULL, 'cliente', 85, 'add', '2014-03-12 09:20:01', '[]', '[]'),
(130, '36dd07ce38b167636f2b1fe96bb44ee6', NULL, 'cliente', 86, 'add', '2014-03-12 09:37:34', '[]', '[]'),
(131, '36dd07ce38b167636f2b1fe96bb44ee6', NULL, 'cliente', 87, 'add', '2014-03-12 09:39:43', '[]', '[]'),
(132, '36dd07ce38b167636f2b1fe96bb44ee6', NULL, 'cliente', 88, 'add', '2014-03-12 09:40:44', '[]', '[]'),
(133, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 89, 'add', '2014-03-12 09:51:20', '[]', '[]'),
(134, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 90, 'add', '2014-04-18 11:44:52', '[]', '[]'),
(135, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 91, 'add', '2014-07-14 15:28:05', '[]', '[]'),
(136, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 92, 'add', '2014-07-14 15:48:24', '[]', '[]'),
(137, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 93, 'add', '2014-07-14 16:18:23', '[]', '[]'),
(138, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 94, 'add', '2014-07-14 16:23:00', '[]', '[]'),
(139, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 95, 'add', '2014-07-14 16:23:21', '[]', '[]'),
(140, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 96, 'add', '2014-07-14 16:25:33', '[]', '[]'),
(141, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 97, 'add', '2014-07-14 16:31:17', '[]', '[]'),
(142, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 98, 'add', '2014-07-14 16:33:29', '[]', '[]'),
(143, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 99, 'add', '2014-07-14 16:37:23', '[]', '[]'),
(144, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 1, 'add', '2014-07-22 10:20:47', '[]', '[]'),
(145, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 2, 'add', '2014-07-22 10:21:54', '[]', '[]'),
(146, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 3, 'add', '2014-07-22 10:22:43', '[]', '[]'),
(147, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 4, 'add', '2014-07-22 10:23:02', '[]', '[]'),
(148, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 5, 'add', '2014-07-22 10:23:16', '[]', '[]'),
(149, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 6, 'add', '2014-07-22 10:23:33', '[]', '[]'),
(150, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 7, 'add', '2014-07-22 10:24:31', '[]', '[]'),
(151, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 8, 'add', '2014-07-22 10:25:09', '[]', '[]'),
(152, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 9, 'add', '2014-07-22 10:25:25', '[]', '[]'),
(153, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 10, 'add', '2014-07-22 10:27:02', '[]', '[]'),
(154, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 11, 'add', '2014-07-22 10:35:10', '[]', '[]'),
(155, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 12, 'add', '2014-07-22 10:41:02', '[]', '[]'),
(156, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 13, 'add', '2014-07-22 10:42:35', '[]', '[]'),
(157, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 13, 'edit', '2014-09-08 09:54:59', '[]', '[]'),
(158, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 13, 'edit', '2014-09-08 09:55:53', '[]', '[]'),
(159, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 13, 'edit', '2014-09-08 09:57:30', '[]', '[]'),
(160, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 13, 'edit', '2014-09-08 09:57:59', '[]', '[]'),
(161, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 13, 'edit', '2014-09-08 09:59:50', '[]', '[]'),
(162, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 16, 'add', '2014-09-08 10:38:16', '[]', '[]'),
(163, '36dd07ce38b167636f2b1fe96bb44ee6', 42, 'cliente', 15, 'edit', '2014-09-08 10:59:12', '[]', '[]'),
(164, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 17, 'registro', '2015-02-03 22:16:05', '[]', '[]'),
(165, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 18, 'registro', '2015-02-03 22:37:23', '[]', '[]'),
(166, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 19, 'registro', '2015-02-03 22:46:48', '[]', '[]'),
(167, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 20, 'registro', '2015-02-03 22:51:39', '[]', '[]'),
(168, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 21, 'registro', '2015-02-03 22:54:26', '[]', '[]'),
(169, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 22, 'registro', '2015-02-04 11:25:41', '[]', '[]'),
(170, '36dd07ce38b167636f2b1fe96bb44ee6', 0, 'catalogo', 23, 'registro', '2015-02-04 11:30:01', '[]', '[]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE IF NOT EXISTS `cargo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`id`, `app_id`, `nombre`, `borrado`) VALUES
(1, '04f50f7dfc94e524e2fc6ce675663c1d', 'vendedor', 'N'),
(2, '04f50f7dfc94e524e2fc6ce675663c1d', 'Abogado', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `prioridad` tinyint(4) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `app_id`, `nombre`, `parent_id`, `prioridad`, `borrado`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'Hombre', 0, 1, 'N'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', 'Mujer', 0, 0, 'N'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', 'Unisex', 0, 0, 'N'),
(4, '36dd07ce38b167636f2b1fe96bb44ee6', 'Remeras Manga Corta', 1, 3, 'N'),
(5, '36dd07ce38b167636f2b1fe96bb44ee6', 'Remeras Manga Larga', 1, 3, 'N'),
(6, '36dd07ce38b167636f2b1fe96bb44ee6', 'Buzo Canguro', 1, 10, 'N'),
(7, '36dd07ce38b167636f2b1fe96bb44ee6', 'Campera', 1, 2, 'N'),
(8, '36dd07ce38b167636f2b1fe96bb44ee6', 'Top', 2, 2, 'N'),
(9, '36dd07ce38b167636f2b1fe96bb44ee6', 'Remera', 2, 4, 'N'),
(10, '36dd07ce38b167636f2b1fe96bb44ee6', 'Cuello en V', 4, 0, 'N'),
(11, '36dd07ce38b167636f2b1fe96bb44ee6', 'Cuello en U', 4, 0, 'N'),
(12, '36dd07ce38b167636f2b1fe96bb44ee6', 'Cuello en V', 5, 0, 'N'),
(13, '36dd07ce38b167636f2b1fe96bb44ee6', 'Cuello en U', 5, 0, 'N'),
(19, '36dd07ce38b167636f2b1fe96bb44ee6', 'Cuello Mao', 0, 0, 'N'),
(20, '36dd07ce38b167636f2b1fe96bb44ee6', 'Zapatillas', 1, 0, 'N'),
(21, 'c96bd135ae37d6153418d5dd766f9d70', 'Hombre', 0, 0, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_tree`
--

CREATE TABLE IF NOT EXISTS `categoria_tree` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `categoria_tree`
--

INSERT INTO `categoria_tree` (`id`, `nombre`, `parent_id`) VALUES
(1, 'FRUTAS', 0),
(2, 'MANZANA', 1),
(3, 'BANANA', 1),
(4, 'VERDURAS', 0),
(5, 'PIMIENTO', 4),
(6, 'VERDE', 5),
(7, 'ROJO', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `nombre_comercial` varchar(250) NOT NULL,
  `tipo` int(11) NOT NULL,
  `telefono1` varchar(20) NOT NULL,
  `telefono2` varchar(20) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `sms1` varchar(20) NOT NULL,
  `sms2` varchar(20) NOT NULL,
  `sms3` varchar(20) NOT NULL,
  `email1` varchar(200) NOT NULL,
  `email2` varchar(200) NOT NULL,
  `email3` varchar(200) NOT NULL,
  `empresa_de_preferencia` varchar(250) NOT NULL,
  `asegurado` int(11) NOT NULL DEFAULT '0',
  `direccion_de_envio` varchar(250) NOT NULL,
  `enviar_a_nombre_de` varchar(100) NOT NULL,
  `razon_social` varchar(250) NOT NULL,
  `tipo_contribucion` enum('Consumidor Final','Excento','No Responsable','Responsable Inscripto','Responsable Monotributo') NOT NULL,
  `cuit` varchar(30) NOT NULL,
  `provincia_id` int(11) DEFAULT NULL,
  `localidad` varchar(250) NOT NULL,
  `muestra_precio` enum('SI','NO') NOT NULL,
  `aplica_iva` enum('SI','NO') NOT NULL,
  `habilita_acceso_pedidos` enum('SI','NO') NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  `estado_id` int(11) DEFAULT NULL,
  `fecha_alta` datetime DEFAULT NULL,
  `direccion_facturacion` varchar(256) DEFAULT NULL,
  `observaciones` varchar(2048) DEFAULT NULL,
  `viajante_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo` (`tipo`,`usuario_id`,`provincia_id`),
  KEY `tipo_2` (`tipo`),
  KEY `pais_id` (`provincia_id`),
  KEY `tipo_3` (`tipo`),
  KEY `app_id` (`app_id`),
  KEY `estado_id` (`estado_id`),
  KEY `viajante_id` (`viajante_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `app_id`, `nombre_comercial`, `tipo`, `telefono1`, `telefono2`, `usuario_id`, `sms1`, `sms2`, `sms3`, `email1`, `email2`, `email3`, `empresa_de_preferencia`, `asegurado`, `direccion_de_envio`, `enviar_a_nombre_de`, `razon_social`, `tipo_contribucion`, `cuit`, `provincia_id`, `localidad`, `muestra_precio`, `aplica_iva`, `habilita_acceso_pedidos`, `borrado`, `estado_id`, `fecha_alta`, `direccion_facturacion`, `observaciones`, `viajante_id`) VALUES
(13, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre comer2', 4, 'sdfsdfsd', 'sdfsdfsdf', 42, 'sms1', 'sms2', 'sms3', 'email1@sdfsd.onm', 'email2@sdfs.com', 'email@asd.com', 'empresa de preed', 34, 'cucha cucha 3434', 'Recibe', 'pepito srl', 'No Responsable', '20227929899', NULL, '', 'SI', 'SI', '', 'N', 1, '2014-09-08 09:59:50', 'popo 234234', 'observa', 0),
(14, '36dd07ce38b167636f2b1fe96bb44ee6', 'Lider Guitar', 2, '345345345', '345345345', 42, '', '', '', 'email1@sdfsd.onm', '', '', '', 0, '', '', '', '', '', NULL, '', 'SI', 'SI', '', 'N', 0, '2014-09-08 10:37:31', '', '', 0),
(15, '36dd07ce38b167636f2b1fe96bb44ee6', 'Lider Guitar', 2, '345345345', '345345345', 42, '', '', '', 'email1@sdfsd.onm', '', '', '', 0, '', '', '', '', '', NULL, '', 'SI', 'SI', '', 'N', 1, '2014-09-08 10:59:12', '', '', 0),
(16, '36dd07ce38b167636f2b1fe96bb44ee6', 'Lider Guitar', 2, '345345345', '345345345', 43, '', '', '', 'email1@sdfsd.onm', '', '', '', 0, '', '', '', '', '', NULL, '', 'SI', 'SI', '', 'N', 0, '2014-09-08 10:38:16', '', '', 0),
(17, '36dd07ce38b167636f2b1fe96bb44ee6', 'pepe', 3, '', '', 0, '', '', '', '', '', '', '', 0, '', '', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-03 22:16:04', NULL, NULL, 0),
(18, '36dd07ce38b167636f2b1fe96bb44ee6', 'pepe5', 3, '', '', 0, '', '', '', '', '', '', 'empresa pref', 34, 'direccion', 'recibe', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-03 22:37:23', NULL, NULL, 0),
(19, '36dd07ce38b167636f2b1fe96bb44ee6', 'PEPE80', 4, '', '', 0, '', '', '', '', '', '', '', 0, '', '', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-03 22:46:48', NULL, NULL, 0),
(20, '36dd07ce38b167636f2b1fe96bb44ee6', 'pepe90', 3, '', '', 0, '', '', '', '', '', '', '', 0, '', '', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-03 22:51:38', NULL, NULL, 0),
(21, '36dd07ce38b167636f2b1fe96bb44ee6', 'pepito8', 3, '', '', 0, '', '', '', '', '', '', '', 0, '', '', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-03 22:54:26', NULL, NULL, 0),
(22, '36dd07ce38b167636f2b1fe96bb44ee6', 'popopo', 5, '', '', 0, '', '', '', '', '', '', '', 0, '', '', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-04 11:25:41', NULL, NULL, 0),
(23, '36dd07ce38b167636f2b1fe96bb44ee6', 'lider', 6, '', '', 0, '', '', '', '', '', '', '', 0, '', '', '', 'Consumidor Final', '', NULL, '', 'SI', 'SI', 'SI', 'N', 0, '2015-02-04 11:30:01', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_estado`
--

CREATE TABLE IF NOT EXISTS `cliente_estado` (
  `id` int(2) NOT NULL DEFAULT '0',
  `descripcion` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente_estado`
--

INSERT INTO `cliente_estado` (`id`, `descripcion`) VALUES
(0, 'Pendiente'),
(1, 'Aceptado'),
(2, 'Rechazado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_tipo`
--

CREATE TABLE IF NOT EXISTS `cliente_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `cliente_tipo`
--

INSERT INTO `cliente_tipo` (`id`, `app_id`, `nombre`, `borrado`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'General', 'N'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', 'Tiendas de Ropas', 'N'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', 'Publico', 'N'),
(4, '36dd07ce38b167636f2b1fe96bb44ee6', 'Motta Stores', 'N'),
(5, '36dd07ce38b167636f2b1fe96bb44ee6', 'Vendedores', 'N'),
(6, '36dd07ce38b167636f2b1fe96bb44ee6', 'Viajantes', 'N'),
(7, '36dd07ce38b167636f2b1fe96bb44ee6', 'Coordinadores', 'N'),
(8, '36dd07ce38b167636f2b1fe96bb44ee6', 'Tiendas de Ropas XX', 'N'),
(9, '36dd07ce38b167636f2b1fe96bb44ee6', 'Tiendas Pepito', 'N'),
(10, '36dd07ce38b167636f2b1fe96bb44ee6', 'General Pepito', 'N'),
(11, '36dd07ce38b167636f2b1fe96bb44ee6', 'Test de Tipo', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE IF NOT EXISTS `comentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comentario` text,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario_por_cliente`
--

CREATE TABLE IF NOT EXISTS `comentario_por_cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `id_comentario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cl` (`id_cliente`),
  KEY `cm` (`id_comentario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foto`
--

CREATE TABLE IF NOT EXISTS `foto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(250) DEFAULT NULL,
  `descripcion` text,
  `id_cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Volcado de datos para la tabla `foto`
--

INSERT INTO `foto` (`id`, `url`, `descripcion`, `id_cliente`) VALUES
(1, '1389298748.jpg', NULL, NULL),
(2, '1389300114.jpg', NULL, NULL),
(3, '1389300120.jpg', NULL, NULL),
(4, '1389300128.jpg', NULL, NULL),
(5, '1389300136.jpg', NULL, NULL),
(6, '1389300148.jpg', NULL, NULL),
(7, '1389300155.jpg', NULL, NULL),
(8, '1389726197.jpg', NULL, NULL),
(9, '1389726211.jpg', NULL, NULL),
(10, '1389726278.jpg', NULL, NULL),
(11, '1389726286.jpg', NULL, NULL),
(12, '1389726574.jpg', NULL, NULL),
(13, '1389726584.jpg', NULL, NULL),
(14, '1389726842.jpg', NULL, NULL),
(15, '1389726851.jpg', NULL, NULL),
(16, '1389726842.jpg', NULL, NULL),
(17, '1389726851.jpg', NULL, NULL),
(18, '1389727232.jpg', NULL, NULL),
(19, '1389727241.jpg', NULL, NULL),
(20, '1389727232.jpg', NULL, NULL),
(21, '1389727241.jpg', NULL, NULL),
(22, '1389727232.jpg', NULL, NULL),
(23, '1389727241.jpg', NULL, NULL),
(24, '1389727232.jpg', NULL, NULL),
(25, '1389727232.jpg', NULL, NULL),
(26, '1389728293.jpg', NULL, NULL),
(27, '1389728305.jpg', NULL, NULL),
(28, '1389727232.jpg', NULL, NULL),
(29, '1389728305.jpg', NULL, NULL),
(30, '1389727232.jpg', NULL, NULL),
(31, '1389728305.jpg', NULL, NULL),
(32, '1389969984.jpg', NULL, NULL),
(33, '1389971710.jpg', NULL, NULL),
(34, '1389971710.jpg', NULL, NULL),
(35, '1389971710.jpg', NULL, NULL),
(36, '1389971710.jpg', NULL, NULL),
(37, '1389971710.jpg', NULL, NULL),
(38, '1389971710.jpg', NULL, NULL),
(39, '1389971710.jpg', NULL, NULL),
(40, '1389727232.jpg', NULL, NULL),
(41, '1389728305.jpg', NULL, NULL),
(42, '1389971710.jpg', NULL, NULL),
(43, '1389971710.jpg', NULL, NULL),
(44, '1389727232.jpg', NULL, NULL),
(45, '1389728305.jpg', NULL, NULL),
(46, '', NULL, NULL),
(47, '1392248602.jpg', NULL, NULL),
(48, '', NULL, NULL),
(49, '', NULL, NULL),
(50, '1420466687.jpg', NULL, NULL),
(51, '1420468225.jpg', NULL, NULL),
(52, '1420473498.jpg', NULL, NULL),
(53, '1420598374.jpg', NULL, NULL),
(54, '1420598808.jpg', NULL, NULL),
(55, '1420598978.jpg', NULL, NULL),
(56, '1420599035.jpg', NULL, NULL),
(57, '1420599063.jpg', NULL, NULL),
(58, '1420599092.jpg', NULL, NULL),
(59, '', NULL, NULL),
(60, '1420599158.jpg', NULL, NULL),
(61, '1420642069.jpg', NULL, NULL),
(62, '1420642128.jpg', NULL, NULL),
(63, '1420642398.jpg', NULL, NULL),
(64, '1420598808.jpg', NULL, NULL),
(65, '1420919965.jpg', NULL, NULL),
(66, '1420919965.jpg', NULL, NULL),
(67, '1420920032.jpg', NULL, NULL),
(68, '1420920070.jpg', NULL, NULL),
(69, '1420920213.jpg', NULL, NULL),
(70, '1420920240.jpg', NULL, NULL),
(71, '1420920263.jpg', NULL, NULL),
(72, '1420920363.jpg', NULL, NULL),
(73, '1420920469.jpg', NULL, NULL),
(74, '1420920363.jpg', NULL, NULL),
(75, '1420987469.jpg', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos_por_producto`
--

CREATE TABLE IF NOT EXISTS `fotos_por_producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_foto` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_foto` (`id_foto`),
  KEY `id_producto` (`id_producto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Volcado de datos para la tabla `fotos_por_producto`
--

INSERT INTO `fotos_por_producto` (`id`, `id_foto`, `id_producto`) VALUES
(53, 53, 2),
(55, 55, 1),
(66, 66, 3),
(67, 67, 4),
(68, 68, 5),
(69, 69, 6),
(70, 70, 7),
(71, 71, 8),
(73, 73, 10),
(74, 74, 9),
(75, 75, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `nombre`) VALUES
(1, 'Admin'),
(2, 'Catalogo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_item`
--

CREATE TABLE IF NOT EXISTS `menu_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `path` varchar(250) DEFAULT NULL,
  `icon_url` varchar(250) DEFAULT NULL,
  `id_parent_menu_item` int(11) DEFAULT '0',
  `prioridad` int(11) DEFAULT NULL,
  `id_menu` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`nombre`),
  KEY `id_menu` (`id_menu`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Volcado de datos para la tabla `menu_item`
--

INSERT INTO `menu_item` (`id`, `nombre`, `path`, `icon_url`, `id_parent_menu_item`, `prioridad`, `id_menu`) VALUES
(1, 'Inicio', '/', NULL, 0, 1, 1),
(2, 'Catalogo', NULL, NULL, 0, 2, 1),
(3, 'Productos', NULL, NULL, 2, 3, 1),
(4, 'Agregar Productos', '/productotextil/add', NULL, 3, 4, 1),
(5, 'Editar Productos', '/productotextil/list', NULL, 3, 5, 1),
(6, 'Editar Stock', '/stock', NULL, 2, 6, 1),
(7, 'Categorias de Productos', NULL, NULL, 2, 7, 1),
(8, 'Agregar Categorias', '/categoria/add', NULL, 7, 8, 1),
(9, 'Editar Categorias', '/categoria/list', NULL, 7, 9, 1),
(10, 'Editar Talles', '/talle/list', NULL, 42, 10, 1),
(11, 'Novedades', NULL, NULL, 2, 11, 1),
(13, 'Editar Novedades', '/novedad/admin', NULL, 11, 13, 1),
(14, 'Informaci&oacute;n Adicional', NULL, NULL, 2, 14, 1),
(15, 'Listar y Editar Secciones', '/seccion/list', NULL, 14, 15, 1),
(16, 'Visualizaci&oacute;n Gr&aacute;fica', NULL, NULL, 2, 16, 1),
(17, 'Cargar Logo', '/logo/add', NULL, 16, 17, 1),
(18, 'Cargar Fondo', '/fondo/cargar', NULL, 16, 18, 1),
(19, 'Color y Tama&ntilde;o de Texto', '/texto/add', NULL, 16, 19, 1),
(20, 'Clientes', NULL, NULL, 0, 20, 1),
(21, 'Agregar Cliente', '/cliente/add', NULL, 20, 21, 1),
(22, 'Listar y Editar Clientes', '/cliente/list', NULL, 20, 22, 1),
(23, 'Exportar Clientes', '/cliente/export', NULL, 20, 23, 1),
(24, 'Editar Tipos de Clientes', '/clientetipo/list', NULL, 20, 25, 1),
(25, 'Aviso de Nuevos Clientes', '/cliente/avisonuevocliente', NULL, 20, 26, 1),
(26, 'Ventas', NULL, NULL, 0, 26, 1),
(27, 'Listar Ventas', '/venta/list', NULL, 26, 27, 1),
(28, 'Aviso de Nuevas Ventas', '/venta/avisonv', NULL, 26, 28, 1),
(29, 'Formas de Pago', '/formadepago', NULL, 26, 29, 1),
(30, 'Informes', NULL, NULL, 0, 30, 1),
(31, 'Productos mas Vendidos', '/informe/masvendido', NULL, 30, 31, 1),
(32, 'Productos menos Vendidos', '/informe/menosvendidos', NULL, 30, 32, 1),
(33, 'Valor de Stock a Venta', '/stock/venta', NULL, 30, 33, 1),
(34, 'Valor de Stock a Costo', '/stock/costo', NULL, 30, 34, 1),
(35, 'Movimientos de Stock', '/stock/movimientos', NULL, 30, 35, 1),
(37, 'Configuracion General', NULL, NULL, 0, 37, 1),
(38, 'Establecer Horario Local', '/horario/list', NULL, 37, 38, 1),
(39, 'Email para reestablecer contrasena', '/usuario/email', NULL, 37, 39, 1),
(40, 'Cambiar Contrase&ntilde;a', '/usuario/password', NULL, 37, 40, 1),
(41, 'Agregar Tipo de Cliente', '/clientetipo/add', NULL, 20, 24, 1),
(42, 'Talles', '', NULL, 2, 10, 1),
(43, 'Agregar Talles', '/talle/add', NULL, 42, 11, 1),
(44, 'Administraci&oacute;n de Usuarios', NULL, NULL, 0, 31, 1),
(45, 'Vendedores', '/vendedor', NULL, 44, 41, 1),
(46, 'Estados de Ventas', '/ventaestado', NULL, 26, 100, 1),
(47, 'Novedades', '/novedades', NULL, 0, 1, 2),
(48, 'Tipos de Talle', '/talletipo', NULL, 42, 100, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `novedad`
--

CREATE TABLE IF NOT EXISTS `novedad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) DEFAULT NULL,
  `imagen` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `posicion` tinyint(1) DEFAULT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `novedad`
--

INSERT INTO `novedad` (`id`, `app_id`, `imagen`, `url`, `posicion`, `borrado`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', '1420046055.jpg', 'www.pepito.com', 9, 'N'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', '1420044170.jpg', 'www.pepito.com', 2, 'N'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', '1420046172.jpg', 'www.pepito.com', 3, 'N'),
(5, '36dd07ce38b167636f2b1fe96bb44ee6', '1420046004.jpg', NULL, 5, 'N'),
(8, '36dd07ce38b167636f2b1fe96bb44ee6', '1423237312.jpg', NULL, 1, 'N'),
(9, '36dd07ce38b167636f2b1fe96bb44ee6', '1420043881.jpg', NULL, 8, 'N'),
(10, '36dd07ce38b167636f2b1fe96bb44ee6', '1420046022.jpg', NULL, 6, 'N'),
(11, '36dd07ce38b167636f2b1fe96bb44ee6', '1420046082.jpg', NULL, 7, 'N'),
(12, '36dd07ce38b167636f2b1fe96bb44ee6', '1420465306.jpg', NULL, 4, 'N'),
(13, 'c96bd135ae37d6153418d5dd766f9d70', '1423163424.jpg', NULL, 1, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_tipo`
--

CREATE TABLE IF NOT EXISTS `pago_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) DEFAULT NULL,
  `descripcion` varchar(250) NOT NULL DEFAULT '',
  `interes` float(4,2) NOT NULL DEFAULT '0.00',
  `contenido` text NOT NULL,
  `borrado` char(1) DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `pago_tipo`
--

INSERT INTO `pago_tipo` (`id`, `app_id`, `descripcion`, `interes`, `contenido`, `borrado`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'Precio de Lista', 0.00, '<P>Ud. dispone de 7 días corridos para enviar el cheque. <BR>Pasado este tiempo, la orden será cancelada, la mercadería será nuevamente puesta a disposición de otros clientes y se tendrá en cuanta para la continuidad como cliente de Motta Company.<BR>La mercadería será enviada dentro de los 7 días posteriores a la recepción del mismo.<BR>El tiempo de entrega depende del trasporte. Motta Company no se responsabiliza por demoras de la empresa trasportista.</P>\r\n<P>Por favor envíe el cheque a la siguiente dirección: <BR>Francisco de Olea 4777<BR>Alejandro Centeno<BR>Córdoba (CP 5009)<BR>Córdoba – Argentina</P>\r\n<P>Gracias por su pedido!<BR>Atentamente</P>\r\n<P>Carlos Cangiano<BR>Motta Company<BR><A href="mailto:carloscangiano@mottaco.com.ar">carloscangiano@mottaco.com.ar</A><BR>Tel: (0351) 155-900312</P>', 'N'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', 'Efectivo', -10.00, '<P>Ud. dispone de 7 días corridos para efectuar el pago. <BR>Pasado este tiempo, la orden será cancelada, la mercadería será nuevamente puesta a disposición de otros clientes y se tendrá en cuanta para la continuidad como cliente de Motta Company.</P>\r\n<P>Por favor comuníquese con nosotros para coordinar el día y horario de pago en la siguiente dirección: <BR>Francisco de Olea 4777<BR>Alejandro Centeno<BR>Córdoba (CP 5009)<BR>Córdoba – Argentina<BR><BR>La mercadería será entregada en el momento.<BR><BR>Gracias por su pedido!<BR>Atentamente</P>\r\n<P>Carlos Cangiano<BR>Motta Company<BR><A href="mailto:carloscangiano@mottaco.com.ar">carloscangiano@mottaco.com.ar</A><BR>Tel: (0351) 155-900312</P>', 'N'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', 'Deposito/Transferencia', -3.00, '<P>Ud. dispone de 7 días corridos para efectuar el depósito. <BR>Pasado este tiempo, la orden será cancelada, la mercadería será nuevamente puesta a disposición de otros clientes y se tendrá en cuanta para la continuidad como cliente de Motta Company.<BR>La mercadería será enviada dentro de los 7 días posteriores a la acreditación de los fondos. <BR>El tiempo de entrega depende del trasporte. Motta Company no se responsabiliza por demoras de la empresa trasportista. <BR></P>\r\n<P>Por favor efectúe el depósito en la siguiente cuenta:  <BR><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><U>Banco:</U> Banco de la Nacion Argentina<FONT face=Verdana> </FONT><BR></SPAN><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><U>Tipo de cuenta:</U> Caja de Ahorros<BR><U>Sucursal:</U> 9201<BR><U>Número de cuenta:</U> 1420948954<BR><U>CBU:</U> 01101429 30014209489547<BR><U>Titular:</U> Juan Carlos Cangiano<BR><U>CUIT:</U> 20-30331249-9<FONT face=Verdana> </FONT><BR></SPAN><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><U>DNI:</U> 30.331.249<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></P>\r\n<P>\r\n<P>Gracias por su pedido!<BR></P>\r\n<P>Atentamente</P>\r\n<P>Carlos Cangiano<BR>Motta Company<BR><A href="mailto:carloscangiano@mottaco.com.ar">carloscangiano@mottaco.com.ar</A><BR>Tel: (0351) 155-900312</P>\r\n<P></P>', 'N'),
(4, '36dd07ce38b167636f2b1fe96bb44ee6', 'Tarjeta de Credito', 10.00, '', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) NOT NULL,
  `iso_code_2` char(2) NOT NULL,
  `iso_code_3` char(3) NOT NULL,
  `address_format_id` int(11) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `IDX_COUNTRIES_NAME` (`nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=240 ;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `nombre`, `iso_code_2`, `iso_code_3`, `address_format_id`, `borrado`) VALUES
(1, 'Afghanistan', 'AF', 'AFG', 1, 'N'),
(2, 'Albania', 'AL', 'ALB', 1, 'N'),
(3, 'Algeria', 'DZ', 'DZA', 1, 'N'),
(4, 'American Samoa', 'AS', 'ASM', 1, 'N'),
(5, 'Andorra', 'AD', 'AND', 1, 'N'),
(6, 'Angola', 'AO', 'AGO', 1, 'N'),
(7, 'Anguilla', 'AI', 'AIA', 1, 'N'),
(8, 'Antarctica', 'AQ', 'ATA', 1, 'N'),
(9, 'Antigua and Barbuda', 'AG', 'ATG', 1, 'N'),
(10, 'Argentina', 'AR', 'ARG', 1, 'N'),
(11, 'Armenia', 'AM', 'ARM', 1, 'N'),
(12, 'Aruba', 'AW', 'ABW', 1, 'N'),
(13, 'Australia', 'AU', 'AUS', 1, 'N'),
(14, 'Austria', 'AT', 'AUT', 5, 'N'),
(15, 'Azerbaijan', 'AZ', 'AZE', 1, 'N'),
(16, 'Bahamas', 'BS', 'BHS', 1, 'N'),
(17, 'Bahrain', 'BH', 'BHR', 1, 'N'),
(18, 'Bangladesh', 'BD', 'BGD', 1, 'N'),
(19, 'Barbados', 'BB', 'BRB', 1, 'N'),
(20, 'Belarus', 'BY', 'BLR', 1, 'N'),
(21, 'Belgium', 'BE', 'BEL', 1, 'N'),
(22, 'Belize', 'BZ', 'BLZ', 1, 'N'),
(23, 'Benin', 'BJ', 'BEN', 1, 'N'),
(24, 'Bermuda', 'BM', 'BMU', 1, 'N'),
(25, 'Bhutan', 'BT', 'BTN', 1, 'N'),
(26, 'Bolivia', 'BO', 'BOL', 1, 'N'),
(27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1, 'N'),
(28, 'Botswana', 'BW', 'BWA', 1, 'N'),
(29, 'Bouvet Island', 'BV', 'BVT', 1, 'N'),
(30, 'Brazil', 'BR', 'BRA', 1, 'N'),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', 1, 'N'),
(32, 'Brunei Darussalam', 'BN', 'BRN', 1, 'N'),
(33, 'Bulgaria', 'BG', 'BGR', 1, 'N'),
(34, 'Burkina Faso', 'BF', 'BFA', 1, 'N'),
(35, 'Burundi', 'BI', 'BDI', 1, 'N'),
(36, 'Cambodia', 'KH', 'KHM', 1, 'N'),
(37, 'Cameroon', 'CM', 'CMR', 1, 'N'),
(38, 'Canada', 'CA', 'CAN', 1, 'N'),
(39, 'Cape Verde', 'CV', 'CPV', 1, 'N'),
(40, 'Cayman Islands', 'KY', 'CYM', 1, 'N'),
(41, 'Central African Republic', 'CF', 'CAF', 1, 'N'),
(42, 'Chad', 'TD', 'TCD', 1, 'N'),
(43, 'Chile', 'CL', 'CHL', 1, 'N'),
(44, 'China', 'CN', 'CHN', 1, 'N'),
(45, 'Christmas Island', 'CX', 'CXR', 1, 'N'),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1, 'N'),
(47, 'Colombia', 'CO', 'COL', 1, 'N'),
(48, 'Comoros', 'KM', 'COM', 1, 'N'),
(49, 'Congo', 'CG', 'COG', 1, 'N'),
(50, 'Cook Islands', 'CK', 'COK', 1, 'N'),
(51, 'Costa Rica', 'CR', 'CRI', 1, 'N'),
(52, 'Cote D''Ivoire', 'CI', 'CIV', 1, 'N'),
(53, 'Croatia', 'HR', 'HRV', 1, 'N'),
(54, 'Cuba', 'CU', 'CUB', 1, 'N'),
(55, 'Cyprus', 'CY', 'CYP', 1, 'N'),
(56, 'Czech Republic', 'CZ', 'CZE', 1, 'N'),
(57, 'Denmark', 'DK', 'DNK', 1, 'N'),
(58, 'Djibouti', 'DJ', 'DJI', 1, 'N'),
(59, 'Dominica', 'DM', 'DMA', 1, 'N'),
(60, 'Dominican Republic', 'DO', 'DOM', 1, 'N'),
(61, 'East Timor', 'TP', 'TMP', 1, 'N'),
(62, 'Ecuador', 'EC', 'ECU', 1, 'N'),
(63, 'Egypt', 'EG', 'EGY', 1, 'N'),
(64, 'El Salvador', 'SV', 'SLV', 1, 'N'),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', 1, 'N'),
(66, 'Eritrea', 'ER', 'ERI', 1, 'N'),
(67, 'Estonia', 'EE', 'EST', 1, 'N'),
(68, 'Ethiopia', 'ET', 'ETH', 1, 'N'),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1, 'N'),
(70, 'Faroe Islands', 'FO', 'FRO', 1, 'N'),
(71, 'Fiji', 'FJ', 'FJI', 1, 'N'),
(72, 'Finland', 'FI', 'FIN', 1, 'N'),
(73, 'France', 'FR', 'FRA', 1, 'N'),
(74, 'France, Metropolitan', 'FX', 'FXX', 1, 'N'),
(75, 'French Guiana', 'GF', 'GUF', 1, 'N'),
(76, 'French Polynesia', 'PF', 'PYF', 1, 'N'),
(77, 'French Southern Territories', 'TF', 'ATF', 1, 'N'),
(78, 'Gabon', 'GA', 'GAB', 1, 'N'),
(79, 'Gambia', 'GM', 'GMB', 1, 'N'),
(80, 'Georgia', 'GE', 'GEO', 1, 'N'),
(81, 'Germany', 'DE', 'DEU', 5, 'N'),
(82, 'Ghana', 'GH', 'GHA', 1, 'N'),
(83, 'Gibraltar', 'GI', 'GIB', 1, 'N'),
(84, 'Greece', 'GR', 'GRC', 1, 'N'),
(85, 'Greenland', 'GL', 'GRL', 1, 'N'),
(86, 'Grenada', 'GD', 'GRD', 1, 'N'),
(87, 'Guadeloupe', 'GP', 'GLP', 1, 'N'),
(88, 'Guam', 'GU', 'GUM', 1, 'N'),
(89, 'Guatemala', 'GT', 'GTM', 1, 'N'),
(90, 'Guinea', 'GN', 'GIN', 1, 'N'),
(91, 'Guinea-bissau', 'GW', 'GNB', 1, 'N'),
(92, 'Guyana', 'GY', 'GUY', 1, 'N'),
(93, 'Haiti', 'HT', 'HTI', 1, 'N'),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1, 'N'),
(95, 'Honduras', 'HN', 'HND', 1, 'N'),
(96, 'Hong Kong', 'HK', 'HKG', 1, 'N'),
(97, 'Hungary', 'HU', 'HUN', 1, 'N'),
(98, 'Iceland', 'IS', 'ISL', 1, 'N'),
(99, 'India', 'IN', 'IND', 1, 'N'),
(100, 'Indonesia', 'ID', 'IDN', 1, 'N'),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1, 'N'),
(102, 'Iraq', 'IQ', 'IRQ', 1, 'N'),
(103, 'Ireland', 'IE', 'IRL', 1, 'N'),
(104, 'Israel', 'IL', 'ISR', 1, 'N'),
(105, 'Italy', 'IT', 'ITA', 1, 'N'),
(106, 'Jamaica', 'JM', 'JAM', 1, 'N'),
(107, 'Japan', 'JP', 'JPN', 1, 'N'),
(108, 'Jordan', 'JO', 'JOR', 1, 'N'),
(109, 'Kazakhstan', 'KZ', 'KAZ', 1, 'N'),
(110, 'Kenya', 'KE', 'KEN', 1, 'N'),
(111, 'Kiribati', 'KI', 'KIR', 1, 'N'),
(112, 'Korea, Democratic People''s Republic of', 'KP', 'PRK', 1, 'N'),
(113, 'Korea, Republic of', 'KR', 'KOR', 1, 'N'),
(114, 'Kuwait', 'KW', 'KWT', 1, 'N'),
(115, 'Kyrgyzstan', 'KG', 'KGZ', 1, 'N'),
(116, 'Lao People''s Democratic Republic', 'LA', 'LAO', 1, 'N'),
(117, 'Latvia', 'LV', 'LVA', 1, 'N'),
(118, 'Lebanon', 'LB', 'LBN', 1, 'N'),
(119, 'Lesotho', 'LS', 'LSO', 1, 'N'),
(120, 'Liberia', 'LR', 'LBR', 1, 'N'),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1, 'N'),
(122, 'Liechtenstein', 'LI', 'LIE', 1, 'N'),
(123, 'Lithuania', 'LT', 'LTU', 1, 'N'),
(124, 'Luxembourg', 'LU', 'LUX', 1, 'N'),
(125, 'Macau', 'MO', 'MAC', 1, 'N'),
(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1, 'N'),
(127, 'Madagascar', 'MG', 'MDG', 1, 'N'),
(128, 'Malawi', 'MW', 'MWI', 1, 'N'),
(129, 'Malaysia', 'MY', 'MYS', 1, 'N'),
(130, 'Maldives', 'MV', 'MDV', 1, 'N'),
(131, 'Mali', 'ML', 'MLI', 1, 'N'),
(132, 'Malta', 'MT', 'MLT', 1, 'N'),
(133, 'Marshall Islands', 'MH', 'MHL', 1, 'N'),
(134, 'Martinique', 'MQ', 'MTQ', 1, 'N'),
(135, 'Mauritania', 'MR', 'MRT', 1, 'N'),
(136, 'Mauritius', 'MU', 'MUS', 1, 'N'),
(137, 'Mayotte', 'YT', 'MYT', 1, 'N'),
(138, 'Mexico', 'MX', 'MEX', 1, 'N'),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', 1, 'N'),
(140, 'Moldova, Republic of', 'MD', 'MDA', 1, 'N'),
(141, 'Monaco', 'MC', 'MCO', 1, 'N'),
(142, 'Mongolia', 'MN', 'MNG', 1, 'N'),
(143, 'Montserrat', 'MS', 'MSR', 1, 'N'),
(144, 'Morocco', 'MA', 'MAR', 1, 'N'),
(145, 'Mozambique', 'MZ', 'MOZ', 1, 'N'),
(146, 'Myanmar', 'MM', 'MMR', 1, 'N'),
(147, 'Namibia', 'NA', 'NAM', 1, 'N'),
(148, 'Nauru', 'NR', 'NRU', 1, 'N'),
(149, 'Nepal', 'NP', 'NPL', 1, 'N'),
(150, 'Netherlands', 'NL', 'NLD', 1, 'N'),
(151, 'Netherlands Antilles', 'AN', 'ANT', 1, 'N'),
(152, 'New Caledonia', 'NC', 'NCL', 1, 'N'),
(153, 'New Zealand', 'NZ', 'NZL', 1, 'N'),
(154, 'Nicaragua', 'NI', 'NIC', 1, 'N'),
(155, 'Niger', 'NE', 'NER', 1, 'N'),
(156, 'Nigeria', 'NG', 'NGA', 1, 'N'),
(157, 'Niue', 'NU', 'NIU', 1, 'N'),
(158, 'Norfolk Island', 'NF', 'NFK', 1, 'N'),
(159, 'Northern Mariana Islands', 'MP', 'MNP', 1, 'N'),
(160, 'Norway', 'NO', 'NOR', 1, 'N'),
(161, 'Oman', 'OM', 'OMN', 1, 'N'),
(162, 'Pakistan', 'PK', 'PAK', 1, 'N'),
(163, 'Palau', 'PW', 'PLW', 1, 'N'),
(164, 'Panama', 'PA', 'PAN', 1, 'N'),
(165, 'Papua New Guinea', 'PG', 'PNG', 1, 'N'),
(166, 'Paraguay', 'PY', 'PRY', 1, 'N'),
(167, 'Peru', 'PE', 'PER', 1, 'N'),
(168, 'Philippines', 'PH', 'PHL', 1, 'N'),
(169, 'Pitcairn', 'PN', 'PCN', 1, 'N'),
(170, 'Poland', 'PL', 'POL', 1, 'N'),
(171, 'Portugal', 'PT', 'PRT', 1, 'N'),
(172, 'Puerto Rico', 'PR', 'PRI', 1, 'N'),
(173, 'Qatar', 'QA', 'QAT', 1, 'N'),
(174, 'Reunion', 'RE', 'REU', 1, 'N'),
(175, 'Romania', 'RO', 'ROM', 1, 'N'),
(176, 'Russian Federation', 'RU', 'RUS', 1, 'N'),
(177, 'Rwanda', 'RW', 'RWA', 1, 'N'),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1, 'N'),
(179, 'Saint Lucia', 'LC', 'LCA', 1, 'N'),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1, 'N'),
(181, 'Samoa', 'WS', 'WSM', 1, 'N'),
(182, 'San Marino', 'SM', 'SMR', 1, 'N'),
(183, 'Sao Tome and Principe', 'ST', 'STP', 1, 'N'),
(184, 'Saudi Arabia', 'SA', 'SAU', 1, 'N'),
(185, 'Senegal', 'SN', 'SEN', 1, 'N'),
(186, 'Seychelles', 'SC', 'SYC', 1, 'N'),
(187, 'Sierra Leone', 'SL', 'SLE', 1, 'N'),
(188, 'Singapore', 'SG', 'SGP', 4, 'N'),
(189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1, 'N'),
(190, 'Slovenia', 'SI', 'SVN', 1, 'N'),
(191, 'Solomon Islands', 'SB', 'SLB', 1, 'N'),
(192, 'Somalia', 'SO', 'SOM', 1, 'N'),
(193, 'South Africa', 'ZA', 'ZAF', 1, 'N'),
(194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1, 'N'),
(195, 'Spain', 'ES', 'ESP', 3, 'N'),
(196, 'Sri Lanka', 'LK', 'LKA', 1, 'N'),
(197, 'St. Helena', 'SH', 'SHN', 1, 'N'),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1, 'N'),
(199, 'Sudan', 'SD', 'SDN', 1, 'N'),
(200, 'Suriname', 'SR', 'SUR', 1, 'N'),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1, 'N'),
(202, 'Swaziland', 'SZ', 'SWZ', 1, 'N'),
(203, 'Sweden', 'SE', 'SWE', 1, 'N'),
(204, 'Switzerland', 'CH', 'CHE', 1, 'N'),
(205, 'Syrian Arab Republic', 'SY', 'SYR', 1, 'N'),
(206, 'Taiwan', 'TW', 'TWN', 1, 'N'),
(207, 'Tajikistan', 'TJ', 'TJK', 1, 'N'),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1, 'N'),
(209, 'Thailand', 'TH', 'THA', 1, 'N'),
(210, 'Togo', 'TG', 'TGO', 1, 'N'),
(211, 'Tokelau', 'TK', 'TKL', 1, 'N'),
(212, 'Tonga', 'TO', 'TON', 1, 'N'),
(213, 'Trinidad and Tobago', 'TT', 'TTO', 1, 'N'),
(214, 'Tunisia', 'TN', 'TUN', 1, 'N'),
(215, 'Turkey', 'TR', 'TUR', 1, 'N'),
(216, 'Turkmenistan', 'TM', 'TKM', 1, 'N'),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', 1, 'N'),
(218, 'Tuvalu', 'TV', 'TUV', 1, 'N'),
(219, 'Uganda', 'UG', 'UGA', 1, 'N'),
(220, 'Ukraine', 'UA', 'UKR', 1, 'N'),
(221, 'United Arab Emirates', 'AE', 'ARE', 1, 'N'),
(222, 'United Kingdom', 'GB', 'GBR', 1, 'N'),
(223, 'United States', 'US', 'USA', 2, 'N'),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1, 'N'),
(225, 'Uruguay', 'UY', 'URY', 1, 'N'),
(226, 'Uzbekistan', 'UZ', 'UZB', 1, 'N'),
(227, 'Vanuatu', 'VU', 'VUT', 1, 'N'),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1, 'N'),
(229, 'Venezuela', 'VE', 'VEN', 1, 'N'),
(230, 'Viet Nam', 'VN', 'VNM', 1, 'N'),
(231, 'Virgin Islands (British)', 'VG', 'VGB', 1, 'N'),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1, 'N'),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1, 'N'),
(234, 'Western Sahara', 'EH', 'ESH', 1, 'N'),
(235, 'Yemen', 'YE', 'YEM', 1, 'N'),
(236, 'Yugoslavia', 'YU', 'YUG', 1, 'N'),
(237, 'Zaire', 'ZR', 'ZAR', 1, 'N'),
(238, 'Zambia', 'ZM', 'ZMB', 1, 'N'),
(239, 'Zimbabwe', 'ZW', 'ZWE', 1, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE IF NOT EXISTS `pedido` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) DEFAULT NULL,
  `id_cliente` int(8) NOT NULL DEFAULT '0',
  `fecha` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `importe` float(15,2) NOT NULL DEFAULT '0.00',
  `id_tipo_pago` int(3) NOT NULL DEFAULT '0',
  `interes` float(5,2) NOT NULL DEFAULT '0.00',
  `iva` float(5,2) NOT NULL DEFAULT '0.00',
  `id_pedido_estado` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id`, `app_id`, `id_cliente`, `fecha`, `importe`, `id_tipo_pago`, `interes`, `iva`, `id_pedido_estado`) VALUES
(13, '04f50f7dfc94e524e2fc6ce675663c1d', 999, '2013-11-11 21:24:36', 3456.09, 1, 1.45, 3.50, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_detalle_por_talle`
--

CREATE TABLE IF NOT EXISTS `pedido_detalle_por_talle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(10) NOT NULL DEFAULT '0',
  `id_producto` int(5) NOT NULL DEFAULT '0',
  `id_talle` int(5) NOT NULL DEFAULT '0',
  `cantidad` int(4) NOT NULL DEFAULT '0',
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_talle`,`id`),
  KEY `id` (`id`),
  KEY `id_talle` (`id_talle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `pedido_detalle_por_talle_ibfk_2` (`id_producto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `pedido_detalle_por_talle`
--

INSERT INTO `pedido_detalle_por_talle` (`id`, `id_pedido`, `id_producto`, `id_talle`, `cantidad`, `precio`) VALUES
(10, 13, 1, 1, 4, 103.45);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_estado`
--

CREATE TABLE IF NOT EXISTS `pedido_estado` (
  `id_estado` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `descripcion` text NOT NULL,
  `color` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `pedido_estado`
--

INSERT INTO `pedido_estado` (`id_estado`, `nombre`, `descripcion`, `color`) VALUES
(1, 'En Revisión', '', '003399'),
(2, 'Anulado', '', '990000'),
(3, 'Entregado. Pago pendiente', '', '333333'),
(4, 'Pagado y Entregado', '', '333333'),
(5, 'Pagado. Entrega pendiente', '', '333333'),
(6, 'Pendiente de pago', '', '333333'),
(7, 'Pendiente de stock', '', 'FF0000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE IF NOT EXISTS `perfil` (
  `nombre` varchar(200) NOT NULL,
  `descripcion` text NOT NULL,
  `parent` varchar(200) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`nombre`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`nombre`, `descripcion`, `parent`, `orden`) VALUES
('ADMIN', '', 'USER', 2),
('GUEST', '', '', 4),
('SUPERADMIN', '', 'ADMIN', 1),
('USER', '', 'GUEST', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE IF NOT EXISTS `personal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `nombre_apellido` varchar(250) NOT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `telefono1` varchar(30) DEFAULT NULL,
  `telefono2` varchar(30) DEFAULT NULL,
  `email1` varchar(100) DEFAULT NULL,
  `email2` varchar(100) DEFAULT NULL,
  `dia_nacimiento` int(11) DEFAULT NULL,
  `mes_nacimiento` int(11) DEFAULT NULL,
  `observaciones` text,
  `borrado` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `cargo_id` (`cargo`),
  KEY `cargo_id_2` (`cargo`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`id`, `app_id`, `nombre_apellido`, `cargo`, `telefono1`, `telefono2`, `email1`, `email2`, `dia_nacimiento`, `mes_nacimiento`, `observaciones`, `borrado`) VALUES
(10, '36dd07ce38b167636f2b1fe96bb44ee6', 'personal 1', 'cargo1', '234234234', '234234234', 'emalsdfsd@sada.com', 'emalsdfsd@sada.com', 3, 3, NULL, 'N'),
(11, '36dd07ce38b167636f2b1fe96bb44ee6', 'Personal 2', 'cargo2', '234234234', '23423423', 'email1@sdf.com', 'email2@dfsd.com', 3, 5, NULL, 'N'),
(12, '36dd07ce38b167636f2b1fe96bb44ee6', 'nuevo per', 'cargo nuevo', 'tel', 'tel2', 'emalsdfsd@sada.com', 'lider', 3, 3, NULL, 'N'),
(13, '36dd07ce38b167636f2b1fe96bb44ee6', 'nuevo per', 'cargo nuevo', 'tel', 'tel2', 'emalsdfsd@sada.com', 'lider', 3, 3, NULL, 'N'),
(14, '36dd07ce38b167636f2b1fe96bb44ee6', 'nuevo per', 'cargo nuevo', 'tel', 'tel2', 'emalsdfsd@sada.com', 'lider', 3, 3, NULL, 'N'),
(15, '36dd07ce38b167636f2b1fe96bb44ee6', 'nuevo per', 'cargo nuevo', 'tel', 'tel2', 'emalsdfsd@sada.com', 'lider', 3, 3, NULL, 'N'),
(16, '36dd07ce38b167636f2b1fe96bb44ee6', 'pers 1', 'cargo nuevo', 'tel', NULL, NULL, NULL, NULL, NULL, NULL, 'N'),
(17, '36dd07ce38b167636f2b1fe96bb44ee6', 'pers 1', 'cargo nuevo', 'tel', NULL, NULL, NULL, NULL, NULL, NULL, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_por_cliente`
--

CREATE TABLE IF NOT EXISTS `personal_por_cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `id_personal` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cliente` (`id_cliente`,`id_personal`),
  KEY `personal_id` (`id_personal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `personal_por_cliente`
--

INSERT INTO `personal_por_cliente` (`id`, `id_cliente`, `id_personal`) VALUES
(12, 13, 15),
(13, 18, 16),
(14, 18, 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privilegio`
--

CREATE TABLE IF NOT EXISTS `privilegio` (
  `nombre` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`nombre`),
  KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `privilegio`
--

INSERT INTO `privilegio` (`nombre`) VALUES
('DELETE'),
('GET'),
('POST'),
('PUT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `codigo` varchar(250) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `id_subcategoria` int(11) NOT NULL,
  `foto` varchar(250) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  `bloqueado_id_usuario` int(11) DEFAULT NULL,
  `bloqueado_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`id_subcategoria`),
  KEY `subcategoria_id` (`id_subcategoria`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `app_id`, `codigo`, `nombre`, `descripcion`, `precio`, `costo`, `id_subcategoria`, `foto`, `borrado`, `bloqueado_id_usuario`, `bloqueado_datetime`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'YYY67364', 'Remera Dub Explosion2', 'Remera blancas con colores rasta', 101.45, 33.56, 4, '', 'N', 42, '2015-01-26 12:36:00'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', 'JH87687', 'Do the Evolution', 'Una camisa manga de lagarto', 150.00, 100.00, 4, '', 'N', 42, '2015-01-10 17:57:50'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', 'UYH65R', 'muchas fotos modified', 'dsfsdfsdf modified', 151.00, 101.00, 10, '', 'N', 42, '2015-01-10 17:59:57'),
(4, '36dd07ce38b167636f2b1fe96bb44ee6', 'HRC0194-B', 'Psicotropic Circle B', '', 101.00, 51.00, 11, '', 'N', 0, NULL),
(5, '36dd07ce38b167636f2b1fe96bb44ee6', 'UHJ-895', 'Camisa Cheta', '', 120.00, 100.00, 11, '', 'N', 0, NULL),
(6, '36dd07ce38b167636f2b1fe96bb44ee6', 'HRC0196', 'Gorila Rastaman', '', 150.00, 100.00, 11, '', 'N', 0, NULL),
(7, '36dd07ce38b167636f2b1fe96bb44ee6', 'asdasd-345', 'Numeros test', '', 150.00, 100.00, 1, '', 'N', 0, NULL),
(8, '36dd07ce38b167636f2b1fe96bb44ee6', 'HG8676876', 'Pepe', 'sdfsd', 146.00, 100.00, 11, '', 'N', 42, '2015-01-10 18:08:22'),
(9, '36dd07ce38b167636f2b1fe96bb44ee6', '3345345', 'Remera corta', 'sdf', 345.00, 234.00, 11, '', 'N', 0, NULL),
(10, '36dd07ce38b167636f2b1fe96bb44ee6', 'HG5656', 'Otra remera', 'sdf', 200.00, 100.00, 10, '', 'N', 0, NULL),
(11, '36dd07ce38b167636f2b1fe96bb44ee6', 'GRFE3434', 'SIn prod textill', 'cvx', 100.00, 100.00, 10, '', 'N', 0, NULL),
(12, '36dd07ce38b167636f2b1fe96bb44ee6', 'TYU543', 'Alterno', 'sdfs', 100.00, 60.00, 7, '', 'N', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_textil`
--

CREATE TABLE IF NOT EXISTS `producto_textil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto` int(11) NOT NULL,
  `talle_tipo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_producto` (`id_producto`,`talle_tipo_id`),
  KEY `talle_tipo_id` (`talle_tipo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `producto_textil`
--

INSERT INTO `producto_textil` (`id`, `id_producto`, `talle_tipo_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 12, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincia`
--

CREATE TABLE IF NOT EXISTS `provincia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NOT NULL,
  `id_provincia` varchar(32) NOT NULL,
  `nombre` varchar(32) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `id_pais` (`id_pais`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=871 ;

--
-- Volcado de datos para la tabla `provincia`
--

INSERT INTO `provincia` (`id`, `id_pais`, `id_provincia`, `nombre`, `borrado`) VALUES
(1, 223, 'AL', 'Alabama', 'N'),
(2, 223, 'AK', 'Alaska', 'N'),
(3, 223, 'AS', 'American Samoa', 'N'),
(4, 223, 'AZ', 'Arizona', 'N'),
(5, 223, 'AR', 'Arkansas', 'N'),
(6, 223, 'AF', 'Armed Forces Africa', 'N'),
(7, 223, 'AA', 'Armed Forces Americas', 'N'),
(8, 223, 'AC', 'Armed Forces Canada', 'N'),
(9, 223, 'AE', 'Armed Forces Europe', 'N'),
(10, 223, 'AM', 'Armed Forces Middle East', 'N'),
(11, 223, 'AP', 'Armed Forces Pacific', 'N'),
(12, 223, 'CA', 'California', 'N'),
(13, 223, 'CO', 'Colorado', 'N'),
(14, 223, 'CT', 'Connecticut', 'N'),
(15, 223, 'DE', 'Delaware', 'N'),
(16, 223, 'DC', 'District of Columbia', 'N'),
(17, 223, 'FM', 'Federated States Of Micronesia', 'N'),
(18, 223, 'FL', 'Florida', 'N'),
(19, 223, 'GA', 'Georgia', 'N'),
(20, 223, 'GU', 'Guam', 'N'),
(21, 223, 'HI', 'Hawaii', 'N'),
(22, 223, 'ID', 'Idaho', 'N'),
(23, 223, 'IL', 'Illinois', 'N'),
(24, 223, 'IN', 'Indiana', 'N'),
(25, 223, 'IA', 'Iowa', 'N'),
(26, 223, 'KS', 'Kansas', 'N'),
(27, 223, 'KY', 'Kentucky', 'N'),
(28, 223, 'LA', 'Louisiana', 'N'),
(29, 223, 'ME', 'Maine', 'N'),
(30, 223, 'MH', 'Marshall Islands', 'N'),
(31, 223, 'MD', 'Maryland', 'N'),
(32, 223, 'MA', 'Massachusetts', 'N'),
(33, 223, 'MI', 'Michigan', 'N'),
(34, 223, 'MN', 'Minnesota', 'N'),
(35, 223, 'MS', 'Mississippi', 'N'),
(36, 223, 'MO', 'Missouri', 'N'),
(37, 223, 'MT', 'Montana', 'N'),
(38, 223, 'NE', 'Nebraska', 'N'),
(39, 223, 'NV', 'Nevada', 'N'),
(40, 223, 'NH', 'New Hampshire', 'N'),
(41, 223, 'NJ', 'New Jersey', 'N'),
(42, 223, 'NM', 'New Mexico', 'N'),
(43, 223, 'NY', 'New York', 'N'),
(44, 223, 'NC', 'North Carolina', 'N'),
(45, 223, 'ND', 'North Dakota', 'N'),
(46, 223, 'MP', 'Northern Mariana Islands', 'N'),
(47, 223, 'OH', 'Ohio', 'N'),
(48, 223, 'OK', 'Oklahoma', 'N'),
(49, 223, 'OR', 'Oregon', 'N'),
(50, 223, 'PW', 'Palau', 'N'),
(51, 223, 'PA', 'Pennsylvania', 'N'),
(52, 223, 'PR', 'Puerto Rico', 'N'),
(53, 223, 'RI', 'Rhode Island', 'N'),
(54, 223, 'SC', 'South Carolina', 'N'),
(55, 223, 'SD', 'South Dakota', 'N'),
(56, 223, 'TN', 'Tennessee', 'N'),
(57, 223, 'TX', 'Texas', 'N'),
(58, 223, 'UT', 'Utah', 'N'),
(59, 223, 'VT', 'Vermont', 'N'),
(60, 223, 'VI', 'Virgin Islands', 'N'),
(61, 223, 'VA', 'Virginia', 'N'),
(62, 223, 'WA', 'Washington', 'N'),
(63, 223, 'WV', 'West Virginia', 'N'),
(64, 223, 'WI', 'Wisconsin', 'N'),
(65, 223, 'WY', 'Wyoming', 'N'),
(66, 38, 'AB', 'Alberta', 'N'),
(67, 38, 'BC', 'British Columbia', 'N'),
(68, 38, 'MB', 'Manitoba', 'N'),
(69, 38, 'NF', 'Newfoundland', 'N'),
(70, 38, 'NB', 'New Brunswick', 'N'),
(71, 38, 'NS', 'Nova Scotia', 'N'),
(72, 38, 'NT', 'Northwest Territories', 'N'),
(73, 38, 'NU', 'Nunavut', 'N'),
(74, 38, 'ON', 'Ontario', 'N'),
(75, 38, 'PE', 'Prince Edward Island', 'N'),
(76, 38, 'QC', 'Quebec', 'N'),
(77, 38, 'SK', 'Saskatchewan', 'N'),
(78, 38, 'YT', 'Yukon Territory', 'N'),
(79, 81, 'NDS', 'Niedersachsen', 'N'),
(80, 81, 'BAW', '', 'N'),
(81, 81, 'BAY', 'Bayern', 'N'),
(82, 81, 'BER', 'Berlin', 'N'),
(83, 81, 'BRG', 'Brandenburg', 'N'),
(84, 81, 'BRE', 'Bremen', 'N'),
(85, 81, 'HAM', 'Hamburg', 'N'),
(86, 81, 'HES', 'Hessen', 'N'),
(87, 81, 'MEC', 'Mecklenburg-Vorpommern', 'N'),
(88, 81, 'NRW', 'Nordrhein-Westfalen', 'N'),
(89, 81, 'RHE', 'Rheinland-Pfalz', 'N'),
(90, 81, 'SAR', 'Saarland', 'N'),
(91, 81, 'SAS', 'Sachsen', 'N'),
(92, 81, 'SAC', 'Sachsen-Anhalt', 'N'),
(93, 81, 'SCN', 'Schleswig-Holstein', 'N'),
(94, 81, 'THE', '', 'N'),
(95, 14, 'WI', 'Wien', 'N'),
(96, 14, 'NO', '', 'N'),
(97, 14, 'OO', '', 'N'),
(98, 14, 'SB', 'Salzburg', 'N'),
(99, 14, 'KN', '', 'N'),
(100, 14, 'ST', 'Steiermark', 'N'),
(101, 14, 'TI', 'Tirol', 'N'),
(102, 14, 'BL', 'Burgenland', 'N'),
(103, 14, 'VB', 'Voralberg', 'N'),
(104, 204, 'AG', 'Aargau', 'N'),
(105, 204, 'AI', 'Appenzell Innerrhoden', 'N'),
(106, 204, 'AR', 'Appenzell Ausserrhoden', 'N'),
(107, 204, 'BE', 'Bern', 'N'),
(108, 204, 'BL', 'Basel-Landschaft', 'N'),
(109, 204, 'BS', 'Basel-Stadt', 'N'),
(110, 204, 'FR', 'Freiburg', 'N'),
(111, 204, 'GE', 'Genf', 'N'),
(112, 204, 'GL', 'Glarus', 'N'),
(113, 204, 'JU', '', 'N'),
(114, 204, 'JU', 'Jura', 'N'),
(115, 204, 'LU', 'Luzern', 'N'),
(116, 204, 'NE', 'Neuenburg', 'N'),
(117, 204, 'NW', 'Nidwalden', 'N'),
(118, 204, 'OW', 'Obwalden', 'N'),
(119, 204, 'SG', 'St. Gallen', 'N'),
(120, 204, 'SH', 'Schaffhausen', 'N'),
(121, 204, 'SO', 'Solothurn', 'N'),
(122, 204, 'SZ', 'Schwyz', 'N'),
(123, 204, 'TG', 'Thurgau', 'N'),
(124, 204, 'TI', 'Tessin', 'N'),
(125, 204, 'UR', 'Uri', 'N'),
(126, 204, 'VD', 'Waadt', 'N'),
(127, 204, 'VS', 'Wallis', 'N'),
(128, 204, 'ZG', 'Zug', 'N'),
(129, 204, 'ZH', '', 'N'),
(130, 195, 'A Coruña', '', 'N'),
(131, 195, 'Alava', 'Alava', 'N'),
(132, 195, 'Albacete', 'Albacete', 'N'),
(133, 195, 'Alicante', 'Alicante', 'N'),
(134, 195, 'Almeria', 'Almeria', 'N'),
(135, 195, 'Asturias', 'Asturias', 'N'),
(136, 195, 'Avila', 'Avila', 'N'),
(137, 195, 'Badajoz', 'Badajoz', 'N'),
(138, 195, 'Baleares', 'Baleares', 'N'),
(139, 195, 'Barcelona', 'Barcelona', 'N'),
(140, 195, 'Burgos', 'Burgos', 'N'),
(141, 195, 'Caceres', 'Caceres', 'N'),
(142, 195, 'Cadiz', 'Cadiz', 'N'),
(143, 195, 'Cantabria', 'Cantabria', 'N'),
(144, 195, 'Castellon', 'Castellon', 'N'),
(145, 195, 'Ceuta', 'Ceuta', 'N'),
(146, 195, 'Ciudad Real', 'Ciudad Real', 'N'),
(147, 195, 'Cordoba', 'Cordoba', 'N'),
(148, 195, 'Cuenca', 'Cuenca', 'N'),
(149, 195, 'Girona', 'Girona', 'N'),
(150, 195, 'Granada', 'Granada', 'N'),
(151, 195, 'Guadalajara', 'Guadalajara', 'N'),
(152, 195, 'Guipuzcoa', 'Guipuzcoa', 'N'),
(153, 195, 'Huelva', 'Huelva', 'N'),
(154, 195, 'Huesca', 'Huesca', 'N'),
(155, 195, 'Jaen', 'Jaen', 'N'),
(156, 195, 'La Rioja', 'La Rioja', 'N'),
(157, 195, 'Las Palmas', 'Las Palmas', 'N'),
(158, 195, 'Leon', 'Leon', 'N'),
(159, 195, 'Lleida', 'Lleida', 'N'),
(160, 195, 'Lugo', 'Lugo', 'N'),
(161, 195, 'Madrid', 'Madrid', 'N'),
(162, 195, 'Malaga', 'Malaga', 'N'),
(163, 195, 'Melilla', 'Melilla', 'N'),
(164, 195, 'Murcia', 'Murcia', 'N'),
(165, 195, 'Navarra', 'Navarra', 'N'),
(166, 195, 'Ourense', 'Ourense', 'N'),
(167, 195, 'Palencia', 'Palencia', 'N'),
(168, 195, 'Pontevedra', 'Pontevedra', 'N'),
(169, 195, 'Salamanca', 'Salamanca', 'N'),
(170, 195, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'N'),
(171, 195, 'Segovia', 'Segovia', 'N'),
(172, 195, 'Sevilla', 'Sevilla', 'N'),
(173, 195, 'Soria', 'Soria', 'N'),
(174, 195, 'Tarragona', 'Tarragona', 'N'),
(175, 195, 'Teruel', 'Teruel', 'N'),
(176, 195, 'Toledo', 'Toledo', 'N'),
(177, 195, 'Valencia', 'Valencia', 'N'),
(178, 195, 'Valladolid', 'Valladolid', 'N'),
(179, 195, 'Vizcaya', 'Vizcaya', 'N'),
(180, 195, 'Zamora', 'Zamora', 'N'),
(181, 195, 'Zaragoza', 'Zaragoza', 'N'),
(182, 13, 'NSW', 'New South Wales', 'N'),
(183, 13, 'VIC', 'Victoria', 'N'),
(184, 13, 'QLD', 'Queensland', 'N'),
(185, 13, 'NT', 'Northern Territory', 'N'),
(186, 13, 'WA', 'Western Australia', 'N'),
(187, 13, 'SA', 'South Australia', 'N'),
(188, 13, 'TAS', 'Tasmania', 'N'),
(189, 13, 'ACT', 'Australian Capital Territory', 'N'),
(190, 153, 'Northland', 'Northland', 'N'),
(191, 153, 'Auckland', 'Auckland', 'N'),
(192, 153, 'Waikato', 'Waikato', 'N'),
(193, 153, 'Bay of Plenty', 'Bay of Plenty', 'N'),
(194, 153, 'Gisborne', 'Gisborne', 'N'),
(195, 153, 'Hawkes Bay', 'Hawkes Bay', 'N'),
(196, 153, 'Taranaki', 'Taranaki', 'N'),
(197, 153, 'Manawatu-Wanganui', 'Manawatu-Wanganui', 'N'),
(198, 153, 'Wellington', 'Wellington', 'N'),
(199, 153, 'West Coast', 'West Coast', 'N'),
(200, 153, 'Canterbury', 'Canterbury', 'N'),
(201, 153, 'Otago', 'Otago', 'N'),
(202, 153, 'Southland', 'Southland', 'N'),
(203, 153, 'Tasman', 'Tasman', 'N'),
(204, 153, 'Nelson', 'Nelson', 'N'),
(205, 153, 'Marlborough', 'Marlborough', 'N'),
(206, 30, 'SP', '', 'N'),
(207, 30, 'RJ', 'Rio de Janeiro', 'N'),
(208, 30, 'PE', 'Pernanbuco', 'N'),
(209, 30, 'BA', 'Bahia', 'N'),
(210, 30, 'AM', 'Amazonas', 'N'),
(211, 30, 'MG', 'Minas Gerais', 'N'),
(212, 30, 'ES', 'Espirito Santo', 'N'),
(213, 30, 'RS', 'Rio Grande do Sul', 'N'),
(214, 30, 'PR', '', 'N'),
(215, 30, 'SC', 'Santa Catarina', 'N'),
(216, 30, 'RG', 'Rio Grande do Norte', 'N'),
(217, 30, 'MS', 'Mato Grosso do Sul', 'N'),
(218, 30, 'MT', 'Mato Grosso', 'N'),
(219, 30, 'GO', 'Goias', 'N'),
(220, 30, 'TO', 'Tocantins', 'N'),
(221, 30, 'DF', 'Distrito Federal', 'N'),
(222, 30, 'RO', 'Rondonia', 'N'),
(223, 30, 'AC', 'Acre', 'N'),
(224, 30, 'AP', 'Amapa', 'N'),
(225, 30, 'RO', 'Roraima', 'N'),
(226, 30, 'AL', 'Alagoas', 'N'),
(227, 30, 'CE', '', 'N'),
(228, 30, 'MA', '', 'N'),
(229, 30, 'PA', '', 'N'),
(230, 30, 'PB', '', 'N'),
(231, 30, 'PI', '', 'N'),
(232, 30, 'SE', 'Sergipe', 'N'),
(233, 43, 'I', '', 'N'),
(234, 43, 'II', '', 'N'),
(235, 43, 'III', '', 'N'),
(236, 43, 'IV', '', 'N'),
(237, 43, 'V', '', 'N'),
(238, 43, 'RM', '', 'N'),
(239, 43, 'VI', '', 'N'),
(240, 43, 'VII', '', 'N'),
(241, 43, 'VIII', '', 'N'),
(242, 43, 'IX', '', 'N'),
(243, 43, 'X', '', 'N'),
(244, 43, 'XI', '', 'N'),
(245, 43, 'XII', '', 'N'),
(246, 47, 'AMA', 'Amazonas', 'N'),
(247, 47, 'ANT', 'Antioquia', 'N'),
(248, 47, 'ARA', 'Arauca', 'N'),
(249, 47, 'ATL', 'Atlantico', 'N'),
(250, 47, 'BOL', 'Bolivar', 'N'),
(251, 47, 'BOY', 'Boyaca', 'N'),
(252, 47, 'CAL', 'Caldas', 'N'),
(253, 47, 'CAQ', 'Caqueta', 'N'),
(254, 47, 'CAS', 'Casanare', 'N'),
(255, 47, 'CAU', 'Cauca', 'N'),
(256, 47, 'CES', 'Cesar', 'N'),
(257, 47, 'CHO', 'Choco', 'N'),
(258, 47, 'COR', 'Cordoba', 'N'),
(259, 47, 'CUN', 'Cundinamarca', 'N'),
(260, 47, 'HUI', 'Huila', 'N'),
(261, 47, 'GUA', 'Guainia', 'N'),
(262, 47, 'GUA', 'Guajira', 'N'),
(263, 47, 'GUV', 'Guaviare', 'N'),
(264, 47, 'MAG', 'Magdalena', 'N'),
(265, 47, 'MET', 'Meta', 'N'),
(266, 47, 'NAR', 'Narino', 'N'),
(267, 47, 'NDS', 'Norte de Santander', 'N'),
(268, 47, 'PUT', 'Putumayo', 'N'),
(269, 47, 'QUI', 'Quindio', 'N'),
(270, 47, 'RIS', 'Risaralda', 'N'),
(271, 47, 'SAI', 'San Andres Islas', 'N'),
(272, 47, 'SAN', 'Santander', 'N'),
(273, 47, 'SUC', 'Sucre', 'N'),
(274, 47, 'TOL', 'Tolima', 'N'),
(275, 47, 'VAL', 'Valle', 'N'),
(276, 47, 'VAU', 'Vaupes', 'N'),
(277, 47, 'VIC', 'Vichada', 'N'),
(278, 73, 'Et', 'Etranger', 'N'),
(279, 73, '01', 'Ain', 'N'),
(280, 73, '02', 'Aisne', 'N'),
(281, 73, '03', 'Allier', 'N'),
(282, 73, '04', 'Alpes de Haute Provence', 'N'),
(283, 73, '05', 'Hautes-Alpes', 'N'),
(284, 73, '06', 'Alpes Maritimes', 'N'),
(285, 73, '07', '', 'N'),
(286, 73, '08', 'Ardennes', 'N'),
(287, 73, '09', '', 'N'),
(288, 73, '10', 'Aube', 'N'),
(289, 73, '11', 'Aude', 'N'),
(290, 73, '12', 'Aveyron', 'N'),
(291, 73, '13', '', 'N'),
(292, 73, '14', 'Calvados', 'N'),
(293, 73, '15', 'Cantal', 'N'),
(294, 73, '16', 'Charente', 'N'),
(295, 73, '17', 'Charente Maritime', 'N'),
(296, 73, '18', 'Cher', 'N'),
(297, 73, '19', '', 'N'),
(298, 73, '2A', 'Corse du Sud', 'N'),
(299, 73, '2B', 'Haute Corse', 'N'),
(300, 73, '21', '', 'N'),
(301, 73, '22', '', 'N'),
(302, 73, '23', 'Creuse', 'N'),
(303, 73, '24', 'Dordogne', 'N'),
(304, 73, '25', 'Doubs', 'N'),
(305, 73, '26', '', 'N'),
(306, 73, '27', 'Eure', 'N'),
(307, 73, '28', 'Eure et Loir', 'N'),
(308, 73, '29', '', 'N'),
(309, 73, '30', 'Gard', 'N'),
(310, 73, '31', 'Haute Garonne', 'N'),
(311, 73, '32', 'Gers', 'N'),
(312, 73, '33', 'Gironde', 'N'),
(313, 73, '34', '', 'N'),
(314, 73, '35', 'Ille et Vilaine', 'N'),
(315, 73, '36', 'Indre', 'N'),
(316, 73, '37', 'Indre et Loire', 'N'),
(317, 73, '38', '', 'N'),
(318, 73, '39', 'Jura', 'N'),
(319, 73, '40', 'Landes', 'N'),
(320, 73, '41', 'Loir et Cher', 'N'),
(321, 73, '42', 'Loire', 'N'),
(322, 73, '43', 'Haute Loire', 'N'),
(323, 73, '44', 'Loire Atlantique', 'N'),
(324, 73, '45', 'Loiret', 'N'),
(325, 73, '46', 'Lot', 'N'),
(326, 73, '47', 'Lot et Garonne', 'N'),
(327, 73, '48', '', 'N'),
(328, 73, '49', 'Maine et Loire', 'N'),
(329, 73, '50', 'Manche', 'N'),
(330, 73, '51', 'Marne', 'N'),
(331, 73, '52', 'Haute Marne', 'N'),
(332, 73, '53', 'Mayenne', 'N'),
(333, 73, '54', 'Meurthe et Moselle', 'N'),
(334, 73, '55', 'Meuse', 'N'),
(335, 73, '56', 'Morbihan', 'N'),
(336, 73, '57', 'Moselle', 'N'),
(337, 73, '58', '', 'N'),
(338, 73, '59', 'Nord', 'N'),
(339, 73, '60', 'Oise', 'N'),
(340, 73, '61', 'Orne', 'N'),
(341, 73, '62', 'Pas de Calais', 'N'),
(342, 73, '63', '', 'N'),
(343, 73, '64', '', 'N'),
(344, 73, '65', '', 'N'),
(345, 73, '66', '', 'N'),
(346, 73, '67', 'Bas Rhin', 'N'),
(347, 73, '68', 'Haut Rhin', 'N'),
(348, 73, '69', '', 'N'),
(349, 73, '70', '', 'N'),
(350, 73, '71', '', 'N'),
(351, 73, '72', 'Sarthe', 'N'),
(352, 73, '73', 'Savoie', 'N'),
(353, 73, '74', 'Haute Savoie', 'N'),
(354, 73, '75', 'Paris', 'N'),
(355, 73, '76', 'Seine Maritime', 'N'),
(356, 73, '77', 'Seine et Marne', 'N'),
(357, 73, '78', 'Yvelines', 'N'),
(358, 73, '79', '', 'N'),
(359, 73, '80', 'Somme', 'N'),
(360, 73, '81', 'Tarn', 'N'),
(361, 73, '82', 'Tarn et Garonne', 'N'),
(362, 73, '83', 'Var', 'N'),
(363, 73, '84', 'Vaucluse', 'N'),
(364, 73, '85', '', 'N'),
(365, 73, '86', 'Vienne', 'N'),
(366, 73, '87', 'Haute Vienne', 'N'),
(367, 73, '88', 'Vosges', 'N'),
(368, 73, '89', 'Yonne', 'N'),
(369, 73, '90', 'Territoire de Belfort', 'N'),
(370, 73, '91', 'Essonne', 'N'),
(371, 73, '92', 'Hauts de Seine', 'N'),
(372, 73, '93', 'Seine St-Denis', 'N'),
(373, 73, '94', 'Val de Marne', 'N'),
(374, 73, '95', 'Val d''Oise', 'N'),
(375, 73, '971 (DOM)', 'Guadeloupe', 'N'),
(376, 73, '972 (DOM)', 'Martinique', 'N'),
(377, 73, '973 (DOM)', 'Guyane', 'N'),
(378, 73, '974 (DOM)', 'Saint Denis', 'N'),
(379, 73, '975 (DOM)', 'St-Pierre de Miquelon', 'N'),
(380, 73, '976 (TOM)', 'Mayotte', 'N'),
(381, 73, '984 (TOM)', 'Terres australes et Antartiques ', 'N'),
(382, 73, '985 (TOM)', '', 'N'),
(383, 73, '986 (TOM)', 'Wallis et Futuna', 'N'),
(384, 73, '987 (TOM)', '', 'N'),
(385, 99, 'DL', 'Delhi', 'N'),
(386, 99, 'MH', 'Maharashtra', 'N'),
(387, 99, 'TN', 'Tamil Nadu', 'N'),
(388, 99, 'KL', 'Kerala', 'N'),
(389, 99, 'AP', 'Andhra Pradesh', 'N'),
(390, 99, 'KA', 'Karnataka', 'N'),
(391, 99, 'GA', 'Goa', 'N'),
(392, 99, 'MP', 'Madhya Pradesh', 'N'),
(393, 99, 'PY', 'Pondicherry', 'N'),
(394, 99, 'GJ', 'Gujarat', 'N'),
(395, 99, 'OR', 'Orrisa', 'N'),
(396, 99, 'CA', 'Chhatisgarh', 'N'),
(397, 99, 'JH', 'Jharkhand', 'N'),
(398, 99, 'BR', 'Bihar', 'N'),
(399, 99, 'WB', 'West Bengal', 'N'),
(400, 99, 'UP', 'Uttar Pradesh', 'N'),
(401, 99, 'RJ', 'Rajasthan', 'N'),
(402, 99, 'PB', 'Punjab', 'N'),
(403, 99, 'HR', 'Haryana', 'N'),
(404, 99, 'CH', 'Chandigarh', 'N'),
(405, 99, 'JK', 'Jammu &amp; Kashmir', 'N'),
(406, 99, 'HP', 'Himachal Pradesh', 'N'),
(407, 99, 'UA', 'Uttaranchal', 'N'),
(408, 99, 'LK', 'Lakshadweep', 'N'),
(409, 99, 'AN', 'Andaman &amp; Nicobar', 'N'),
(410, 99, 'MG', 'Meghalaya', 'N'),
(411, 99, 'AS', 'Assam', 'N'),
(412, 99, 'DR', 'Dadra &amp; Nagar Haveli', 'N'),
(413, 99, 'DN', 'Daman &amp; Diu', 'N'),
(414, 99, 'SK', 'Sikkim', 'N'),
(415, 99, 'TR', 'Tripura', 'N'),
(416, 99, 'MZ', 'Mizoram', 'N'),
(417, 99, 'MN', 'Manipur', 'N'),
(418, 99, 'NL', 'Nagaland', 'N'),
(419, 99, 'AR', 'Arunachal Pradesh', 'N'),
(420, 105, 'AG', 'Agrigento', 'N'),
(421, 105, 'AL', 'Alessandria', 'N'),
(422, 105, 'AN', 'Ancona', 'N'),
(423, 105, 'AO', 'Aosta', 'N'),
(424, 105, 'AR', 'Arezzo', 'N'),
(425, 105, 'AP', 'Ascoli Piceno', 'N'),
(426, 105, 'AT', 'Asti', 'N'),
(427, 105, 'AV', 'Avellino', 'N'),
(428, 105, 'BA', 'Bari', 'N'),
(429, 105, 'BL', 'Belluno', 'N'),
(430, 105, 'BN', 'Benevento', 'N'),
(431, 105, 'BG', 'Bergamo', 'N'),
(432, 105, 'BI', 'Biella', 'N'),
(433, 105, 'BO', 'Bologna', 'N'),
(434, 105, 'BZ', 'Bolzano', 'N'),
(435, 105, 'BS', 'Brescia', 'N'),
(436, 105, 'BR', 'Brindisi', 'N'),
(437, 105, 'CA', 'Cagliari', 'N'),
(438, 105, 'CL', 'Caltanissetta', 'N'),
(439, 105, 'CB', 'Campobasso', 'N'),
(440, 105, 'CE', 'Caserta', 'N'),
(441, 105, 'CT', 'Catania', 'N'),
(442, 105, 'CZ', 'Catanzaro', 'N'),
(443, 105, 'CH', 'Chieti', 'N'),
(444, 105, 'CO', 'Como', 'N'),
(445, 105, 'CS', 'Cosenza', 'N'),
(446, 105, 'CR', 'Cremona', 'N'),
(447, 105, 'KR', 'Crotone', 'N'),
(448, 105, 'CN', 'Cuneo', 'N'),
(449, 105, 'EN', 'Enna', 'N'),
(450, 105, 'FE', 'Ferrara', 'N'),
(451, 105, 'FI', 'Firenze', 'N'),
(452, 105, 'FG', 'Foggia', 'N'),
(453, 105, 'FO', '', 'N'),
(454, 105, 'FR', 'Frosinone', 'N'),
(455, 105, 'GE', 'Genova', 'N'),
(456, 105, 'GO', 'Gorizia', 'N'),
(457, 105, 'GR', 'Grosseto', 'N'),
(458, 105, 'IM', 'Imperia', 'N'),
(459, 105, 'IS', 'Isernia', 'N'),
(460, 105, 'AQ', 'Aquila', 'N'),
(461, 105, 'SP', 'La Spezia', 'N'),
(462, 105, 'LT', 'Latina', 'N'),
(463, 105, 'LE', 'Lecce', 'N'),
(464, 105, 'LC', 'Lecco', 'N'),
(465, 105, 'LI', 'Livorno', 'N'),
(466, 105, 'LO', 'Lodi', 'N'),
(467, 105, 'LU', 'Lucca', 'N'),
(468, 105, 'MC', 'Macerata', 'N'),
(469, 105, 'MN', 'Mantova', 'N'),
(470, 105, 'MS', 'Massa-Carrara', 'N'),
(471, 105, 'MT', 'Matera', 'N'),
(472, 105, 'ME', 'Messina', 'N'),
(473, 105, 'MI', 'Milano', 'N'),
(474, 105, 'MO', 'Modena', 'N'),
(475, 105, 'NA', 'Napoli', 'N'),
(476, 105, 'NO', 'Novara', 'N'),
(477, 105, 'NU', 'Nuoro', 'N'),
(478, 105, 'OR', 'Oristano', 'N'),
(479, 105, 'PD', 'Padova', 'N'),
(480, 105, 'PA', 'Palermo', 'N'),
(481, 105, 'PR', 'Parma', 'N'),
(482, 105, 'PG', 'Perugia', 'N'),
(483, 105, 'PV', 'Pavia', 'N'),
(484, 105, 'PS', 'Pesaro e Urbino', 'N'),
(485, 105, 'PE', 'Pescara', 'N'),
(486, 105, 'PC', 'Piacenza', 'N'),
(487, 105, 'PI', 'Pisa', 'N'),
(488, 105, 'PT', 'Pistoia', 'N'),
(489, 105, 'PN', 'Pordenone', 'N'),
(490, 105, 'PZ', 'Potenza', 'N'),
(491, 105, 'PO', 'Prato', 'N'),
(492, 105, 'RG', 'Ragusa', 'N'),
(493, 105, 'RA', 'Ravenna', 'N'),
(494, 105, 'RC', 'Reggio di Calabria', 'N'),
(495, 105, 'RE', 'Reggio Emilia', 'N'),
(496, 105, 'RI', 'Rieti', 'N'),
(497, 105, 'RN', 'Rimini', 'N'),
(498, 105, 'RM', 'Roma', 'N'),
(499, 105, 'RO', 'Rovigo', 'N'),
(500, 105, 'SA', 'Salerno', 'N'),
(501, 105, 'SS', 'Sassari', 'N'),
(502, 105, 'SV', 'Savona', 'N'),
(503, 105, 'SI', 'Siena', 'N'),
(504, 105, 'SR', 'Siracusa', 'N'),
(505, 105, 'SO', 'Sondrio', 'N'),
(506, 105, 'TA', 'Taranto', 'N'),
(507, 105, 'TE', 'Teramo', 'N'),
(508, 105, 'TR', 'Terni', 'N'),
(509, 105, 'TO', 'Torino', 'N'),
(510, 105, 'TP', 'Trapani', 'N'),
(511, 105, 'TN', 'Trento', 'N'),
(512, 105, 'TV', 'Treviso', 'N'),
(513, 105, 'TS', 'Trieste', 'N'),
(514, 105, 'UD', 'Udine', 'N'),
(515, 105, 'VA', 'Varese', 'N'),
(516, 105, 'VE', 'Venezia', 'N'),
(517, 105, 'VB', 'Verbania', 'N'),
(518, 105, 'VC', 'Vercelli', 'N'),
(519, 105, 'VR', 'Verona', 'N'),
(520, 105, 'VV', 'Vibo Valentia', 'N'),
(521, 105, 'VI', 'Vicenza', 'N'),
(522, 105, 'VT', 'Viterbo', 'N'),
(523, 107, 'Niigata', 'Niigata', 'N'),
(524, 107, 'Toyama', 'Toyama', 'N'),
(525, 107, 'Ishikawa', 'Ishikawa', 'N'),
(526, 107, 'Fukui', 'Fukui', 'N'),
(527, 107, 'Yamanashi', 'Yamanashi', 'N'),
(528, 107, 'Nagano', 'Nagano', 'N'),
(529, 107, 'Gifu', 'Gifu', 'N'),
(530, 107, 'Shizuoka', 'Shizuoka', 'N'),
(531, 107, 'Aichi', 'Aichi', 'N'),
(532, 107, 'Mie', 'Mie', 'N'),
(533, 107, 'Shiga', 'Shiga', 'N'),
(534, 107, 'Kyoto', 'Kyoto', 'N'),
(535, 107, 'Osaka', 'Osaka', 'N'),
(536, 107, 'Hyogo', 'Hyogo', 'N'),
(537, 107, 'Nara', 'Nara', 'N'),
(538, 107, 'Wakayama', 'Wakayama', 'N'),
(539, 107, 'Tottori', 'Tottori', 'N'),
(540, 107, 'Shimane', 'Shimane', 'N'),
(541, 107, 'Okayama', 'Okayama', 'N'),
(542, 107, 'Hiroshima', 'Hiroshima', 'N'),
(543, 107, 'Yamaguchi', 'Yamaguchi', 'N'),
(544, 107, 'Tokushima', 'Tokushima', 'N'),
(545, 107, 'Kagawa', 'Kagawa', 'N'),
(546, 107, 'Ehime', 'Ehime', 'N'),
(547, 107, 'Kochi', 'Kochi', 'N'),
(548, 107, 'Fukuoka', 'Fukuoka', 'N'),
(549, 107, 'Saga', 'Saga', 'N'),
(550, 107, 'Nagasaki', 'Nagasaki', 'N'),
(551, 107, 'Kumamoto', 'Kumamoto', 'N'),
(552, 107, 'Oita', 'Oita', 'N'),
(553, 107, 'Miyazaki', 'Miyazaki', 'N'),
(554, 107, 'Kagoshima', 'Kagoshima', 'N'),
(555, 129, 'JOH', 'Johor', 'N'),
(556, 129, 'KDH', 'Kedah', 'N'),
(557, 129, 'KEL', 'Kelantan', 'N'),
(558, 129, 'KL', 'Kuala Lumpur', 'N'),
(559, 129, 'MEL', 'Melaka', 'N'),
(560, 129, 'NS', 'Negeri Sembilan', 'N'),
(561, 129, 'PAH', 'Pahang', 'N'),
(562, 129, 'PRK', 'Perak', 'N'),
(563, 129, 'PER', 'Perlis', 'N'),
(564, 129, 'PP', 'Pulau Pinang', 'N'),
(565, 129, 'SAB', 'Sabah', 'N'),
(566, 129, 'SWK', 'Sarawak', 'N'),
(567, 129, 'SEL', 'Selangor', 'N'),
(568, 129, 'TER', 'Terengganu', 'N'),
(569, 129, 'LAB', 'W.P.Labuan', 'N'),
(570, 138, 'AGS', 'Aguascalientes', 'N'),
(571, 138, 'BC', 'Baja California', 'N'),
(572, 138, 'BCS', 'Baja California Sur', 'N'),
(573, 138, 'CAM', 'Campeche', 'N'),
(574, 138, 'COA', 'Coahuila', 'N'),
(575, 138, 'COL', 'Colima', 'N'),
(576, 138, 'CHI', 'Chiapas', 'N'),
(577, 138, 'CHIH', 'Chihuahua', 'N'),
(578, 138, 'DF', 'Distrito Federal', 'N'),
(579, 138, 'DGO', 'Durango', 'N'),
(580, 138, 'MEX', 'Estado de Mexico', 'N'),
(581, 138, 'GTO', 'Guanajuato', 'N'),
(582, 138, 'GRO', 'Guerrero', 'N'),
(583, 138, 'HGO', 'Hidalgo', 'N'),
(584, 138, 'JAL', 'Jalisco', 'N'),
(585, 138, 'MCH', 'Michoacan', 'N'),
(586, 138, 'MOR', 'Morelos', 'N'),
(587, 138, 'NAY', 'Nayarit', 'N'),
(588, 138, 'NL', 'Nuevo Leon', 'N'),
(589, 138, 'OAX', 'Oaxaca', 'N'),
(590, 138, 'PUE', 'Puebla', 'N'),
(591, 138, 'QRO', 'Queretaro', 'N'),
(592, 138, 'QR', 'Quintana Roo', 'N'),
(593, 138, 'SLP', 'San Luis Potosi', 'N'),
(594, 138, 'SIN', 'Sinaloa', 'N'),
(595, 138, 'SON', 'Sonora', 'N'),
(596, 138, 'TAB', 'Tabasco', 'N'),
(597, 138, 'TMPS', 'Tamaulipas', 'N'),
(598, 138, 'TLAX', 'Tlaxcala', 'N'),
(599, 138, 'VER', 'Veracruz', 'N'),
(600, 138, 'YUC', 'Yucatan', 'N'),
(601, 138, 'ZAC', 'Zacatecas', 'N'),
(602, 160, 'OSL', 'Oslo', 'N'),
(603, 160, 'AKE', 'Akershus', 'N'),
(604, 160, 'AUA', 'Aust-Agder', 'N'),
(605, 160, 'BUS', 'Buskerud', 'N'),
(606, 160, 'FIN', 'Finnmark', 'N'),
(607, 160, 'HED', 'Hedmark', 'N'),
(608, 160, 'HOR', 'Hordaland', 'N'),
(609, 160, 'MOR', '', 'N'),
(610, 160, 'NOR', 'Nordland', 'N'),
(611, 160, 'NTR', '', 'N'),
(612, 160, 'OPP', 'Oppland', 'N'),
(613, 160, 'ROG', 'Rogaland', 'N'),
(614, 160, 'SOF', 'Sogn og Fjordane', 'N'),
(615, 160, 'STR', '', 'N'),
(616, 160, 'TEL', 'Telemark', 'N'),
(617, 160, 'TRO', 'Troms', 'N'),
(618, 160, 'VEA', 'Vest-Agder', 'N'),
(619, 160, 'OST', '', 'N'),
(620, 160, 'SVA', 'Svalbard', 'N'),
(621, 99, 'KHI', 'Karachi', 'N'),
(622, 99, 'LH', 'Lahore', 'N'),
(623, 99, 'ISB', 'Islamabad', 'N'),
(624, 99, 'QUE', 'Quetta', 'N'),
(625, 99, 'PSH', 'Peshawar', 'N'),
(626, 99, 'GUJ', 'Gujrat', 'N'),
(627, 99, 'SAH', 'Sahiwal', 'N'),
(628, 99, 'FSB', 'Faisalabad', 'N'),
(629, 99, 'RIP', 'Rawal Pindi', 'N'),
(630, 175, 'AB', 'Alba', 'N'),
(631, 175, 'AR', 'Arad', 'N'),
(632, 175, 'AG', 'Arges', 'N'),
(633, 175, 'BC', 'Bacau', 'N'),
(634, 175, 'BH', 'Bihor', 'N'),
(635, 175, 'BN', 'Bistrita-Nasaud', 'N'),
(636, 175, 'BT', 'Botosani', 'N'),
(637, 175, 'BV', 'Brasov', 'N'),
(638, 175, 'BR', 'Braila', 'N'),
(639, 175, 'B', 'Bucuresti', 'N'),
(640, 175, 'BZ', 'Buzau', 'N'),
(641, 175, 'CS', 'Caras-Severin', 'N'),
(642, 175, 'CL', 'Calarasi', 'N'),
(643, 175, 'CJ', 'Cluj', 'N'),
(644, 175, 'CT', 'Constanta', 'N'),
(645, 175, 'CV', 'Covasna', 'N'),
(646, 175, 'DB', 'Dimbovita', 'N'),
(647, 175, 'DJ', 'Dolj', 'N'),
(648, 175, 'GL', 'Galati', 'N'),
(649, 175, 'GR', 'Giurgiu', 'N'),
(650, 175, 'GJ', 'Gorj', 'N'),
(651, 175, 'HR', 'Harghita', 'N'),
(652, 175, 'HD', 'Hunedoara', 'N'),
(653, 175, 'IL', 'Ialomita', 'N'),
(654, 175, 'IS', 'Iasi', 'N'),
(655, 175, 'IF', 'Ilfov', 'N'),
(656, 175, 'MM', 'Maramures', 'N'),
(657, 175, 'MH', 'Mehedint', 'N'),
(658, 175, 'MS', 'Mures', 'N'),
(659, 175, 'NT', 'Neamt', 'N'),
(660, 175, 'OT', 'Olt', 'N'),
(661, 175, 'PH', 'Prahova', 'N'),
(662, 175, 'SM', 'Satu-Mare', 'N'),
(663, 175, 'SJ', 'Salaj', 'N'),
(664, 175, 'SB', 'Sibiu', 'N'),
(665, 175, 'SV', 'Suceava', 'N'),
(666, 175, 'TR', 'Teleorman', 'N'),
(667, 175, 'TM', 'Timis', 'N'),
(668, 175, 'TL', 'Tulcea', 'N'),
(669, 175, 'VS', 'Vaslui', 'N'),
(670, 175, 'VL', 'Valcea', 'N'),
(671, 175, 'VN', 'Vrancea', 'N'),
(672, 193, 'WP', 'Western Cape', 'N'),
(673, 193, 'GP', 'Gauteng', 'N'),
(674, 193, 'KZN', 'Kwazulu-Natal', 'N'),
(675, 193, 'NC', 'Northern-Cape', 'N'),
(676, 193, 'EC', 'Eastern-Cape', 'N'),
(677, 193, 'MP', 'Mpumalanga', 'N'),
(678, 193, 'NW', 'North-West', 'N'),
(679, 193, 'FS', 'Free State', 'N'),
(680, 193, 'NP', 'Northern Province', 'N'),
(681, 215, 'ADANA', 'ADANA', 'N'),
(682, 215, 'ADIYAMAN', 'ADIYAMAN', 'N'),
(683, 215, 'AFYON', 'AFYON', 'N'),
(684, 215, 'AGRI', 'AGRI', 'N'),
(685, 215, 'AMASYA', 'AMASYA', 'N'),
(686, 215, 'ANKARA', 'ANKARA', 'N'),
(687, 215, 'ANTALYA', 'ANTALYA', 'N'),
(688, 215, 'ARTVIN', 'ARTVIN', 'N'),
(689, 215, 'AYDIN', 'AYDIN', 'N'),
(690, 215, 'BALIKESIR', 'BALIKESIR', 'N'),
(691, 215, 'BILECIK', 'BILECIK', 'N'),
(692, 215, 'BINGÖL', '', 'N'),
(693, 215, 'BITLIS', 'BITLIS', 'N'),
(694, 215, 'BOLU', 'BOLU', 'N'),
(695, 215, 'BURDUR', 'BURDUR', 'N'),
(696, 215, 'BURSA', 'BURSA', 'N'),
(697, 215, 'ÇANAKKALE', '', 'N'),
(698, 215, 'ÇANKIRI', '', 'N'),
(699, 215, 'ÇORUM', '', 'N'),
(700, 215, 'DENIZLI', 'DENIZLI', 'N'),
(701, 215, 'DIYARBAKIR', 'DIYARBAKIR', 'N'),
(702, 215, 'EDIRNE', 'EDIRNE', 'N'),
(703, 215, 'ELAZIG', 'ELAZIG', 'N'),
(704, 215, 'ERZINCAN', 'ERZINCAN', 'N'),
(705, 215, 'ERZURUM', 'ERZURUM', 'N'),
(706, 215, 'ESKISEHIR', 'ESKISEHIR', 'N'),
(707, 215, 'GAZIANTEP', 'GAZIANTEP', 'N'),
(708, 215, 'GIRESUN', 'GIRESUN', 'N'),
(709, 215, 'GÜMÜSHANE', '', 'N'),
(710, 215, 'HAKKARI', 'HAKKARI', 'N'),
(711, 215, 'HATAY', 'HATAY', 'N'),
(712, 215, 'ISPARTA', 'ISPARTA', 'N'),
(713, 215, 'IÇEL', '', 'N'),
(714, 215, 'ISTANBUL', 'ISTANBUL', 'N'),
(715, 215, 'IZMIR', 'IZMIR', 'N'),
(716, 215, 'KARS', 'KARS', 'N'),
(717, 215, 'KASTAMONU', 'KASTAMONU', 'N'),
(718, 215, 'KAYSERI', 'KAYSERI', 'N'),
(719, 215, 'KIRKLARELI', 'KIRKLARELI', 'N'),
(720, 215, 'KIRSEHIR', 'KIRSEHIR', 'N'),
(721, 215, 'KOCAELI', 'KOCAELI', 'N'),
(722, 215, 'KONYA', 'KONYA', 'N'),
(723, 215, 'KÜTAHYA', '', 'N'),
(724, 215, 'MALATYA', 'MALATYA', 'N'),
(725, 215, 'MANISA', 'MANISA', 'N'),
(726, 215, 'KAHRAMANMARAS', 'KAHRAMANMARAS', 'N'),
(727, 215, 'MARDIN', 'MARDIN', 'N'),
(728, 215, 'MUGLA', 'MUGLA', 'N'),
(729, 215, 'MUS', 'MUS', 'N'),
(730, 215, 'NEVSEHIR', 'NEVSEHIR', 'N'),
(731, 215, 'NIGDE', 'NIGDE', 'N'),
(732, 215, 'ORDU', 'ORDU', 'N'),
(733, 215, 'RIZE', 'RIZE', 'N'),
(734, 215, 'SAKARYA', 'SAKARYA', 'N'),
(735, 215, 'SAMSUN', 'SAMSUN', 'N'),
(736, 215, 'SIIRT', 'SIIRT', 'N'),
(737, 215, 'SINOP', 'SINOP', 'N'),
(738, 215, 'SIVAS', 'SIVAS', 'N'),
(739, 215, 'TEKIRDAG', 'TEKIRDAG', 'N'),
(740, 215, 'TOKAT', 'TOKAT', 'N'),
(741, 215, 'TRABZON', 'TRABZON', 'N'),
(742, 215, 'TUNCELI', 'TUNCELI', 'N'),
(743, 215, 'SANLIURFA', 'SANLIURFA', 'N'),
(744, 215, 'USAK', 'USAK', 'N'),
(745, 215, 'VAN', 'VAN', 'N'),
(746, 215, 'YOZGAT', 'YOZGAT', 'N'),
(747, 215, 'ZONGULDAK', 'ZONGULDAK', 'N'),
(748, 215, 'AKSARAY', 'AKSARAY', 'N'),
(749, 215, 'BAYBURT', 'BAYBURT', 'N'),
(750, 215, 'KARAMAN', 'KARAMAN', 'N'),
(751, 215, 'KIRIKKALE', 'KIRIKKALE', 'N'),
(752, 215, 'BATMAN', 'BATMAN', 'N'),
(753, 215, 'SIRNAK', 'SIRNAK', 'N'),
(754, 215, 'BARTIN', 'BARTIN', 'N'),
(755, 215, 'ARDAHAN', 'ARDAHAN', 'N'),
(756, 215, 'IGDIR', 'IGDIR', 'N'),
(757, 215, 'YALOVA', 'YALOVA', 'N'),
(758, 215, 'KARABÜK', '', 'N'),
(759, 215, 'KILIS', 'KILIS', 'N'),
(760, 215, 'OSMANIYE', 'OSMANIYE', 'N'),
(761, 215, 'DÜZCE', '', 'N'),
(762, 229, 'AM', 'Amazonas', 'N'),
(763, 229, 'AN', '', 'N'),
(764, 229, 'AR', 'Aragua', 'N'),
(765, 229, 'AP', 'Apure', 'N'),
(766, 229, 'BA', 'Barinas', 'N'),
(767, 229, 'BO', '', 'N'),
(768, 229, 'CA', 'Carabobo', 'N'),
(769, 229, 'CO', 'Cojedes', 'N'),
(770, 229, 'DA', 'Delta Amacuro', 'N'),
(771, 229, 'DC', 'Distrito Capital', 'N'),
(772, 229, 'FA', '', 'N'),
(773, 229, 'GA', '', 'N'),
(774, 229, 'GU', 'Guayana', 'N'),
(775, 229, 'LA', 'Lara', 'N'),
(776, 229, 'ME', '', 'N'),
(777, 229, 'MI', 'Miranda', 'N'),
(778, 229, 'MO', 'Monagas', 'N'),
(779, 229, 'NE', 'Nueva Esparta', 'N'),
(780, 229, 'PO', 'Portuguesa', 'N'),
(781, 229, 'SU', 'Sucre', 'N'),
(782, 229, 'TA', '', 'N'),
(783, 229, 'TU', 'Trujillo', 'N'),
(784, 229, 'VA', 'Vargas', 'N'),
(785, 229, 'YA', 'Yaracuy', 'N'),
(786, 229, 'ZU', 'Zulia', 'N'),
(787, 222, 'AVON', 'Avon', 'N'),
(788, 222, 'BEDS', 'Bedfordshire', 'N'),
(789, 222, 'BERK', 'Berkshire', 'N'),
(790, 222, 'BIRM', 'Birmingham', 'N'),
(791, 222, 'BORD', 'Borders', 'N'),
(792, 222, 'BUCK', 'Buckinghamshire', 'N'),
(793, 222, 'CAMB', 'Cambridgeshire', 'N'),
(794, 222, 'CENT', 'Central', 'N'),
(795, 222, 'CHES', 'Cheshire', 'N'),
(796, 222, 'CLEV', 'Cleveland', 'N'),
(797, 222, 'CLWY', 'Clwyd', 'N'),
(798, 222, 'CORN', 'Cornwall', 'N'),
(799, 222, 'CUMB', 'Cumbria', 'N'),
(800, 222, 'DERB', 'Derbyshire', 'N'),
(801, 222, 'DEVO', 'Devon', 'N'),
(802, 222, 'DORS', 'Dorset', 'N'),
(803, 222, 'DUMF', 'Dumfries &amp; Galloway', 'N'),
(804, 222, 'DURH', 'Durham', 'N'),
(805, 222, 'DYFE', 'Dyfed', 'N'),
(806, 222, 'ESUS', 'East Sussex', 'N'),
(807, 222, 'ESSE', 'Essex', 'N'),
(808, 222, 'FIFE', 'Fife', 'N'),
(809, 222, 'GLAM', 'Glamorgan', 'N'),
(810, 222, 'GLOU', 'Gloucestershire', 'N'),
(811, 222, 'GRAM', 'Grampian', 'N'),
(812, 222, 'GWEN', 'Gwent', 'N'),
(813, 222, 'GWYN', 'Gwynedd', 'N'),
(814, 222, 'HAMP', 'Hampshire', 'N'),
(815, 222, 'HERE', 'Hereford &amp; Worcester', 'N'),
(816, 222, 'HERT', 'Hertfordshire', 'N'),
(817, 222, 'HUMB', 'Humberside', 'N'),
(818, 222, 'KENT', 'Kent', 'N'),
(819, 222, 'LANC', 'Lancashire', 'N'),
(820, 222, 'LEIC', 'Leicestershire', 'N'),
(821, 222, 'LINC', 'Lincolnshire', 'N'),
(822, 222, 'LOND', 'London', 'N'),
(823, 222, 'LOTH', 'Lothian', 'N'),
(824, 222, 'MANC', 'Manchester', 'N'),
(825, 222, 'MERS', 'Merseyside', 'N'),
(826, 222, 'NORF', 'Norfolk', 'N'),
(827, 222, 'NYOR', 'North Yorkshire', 'N'),
(828, 222, 'NWHI', 'North west Highlands', 'N'),
(829, 222, 'NHAM', 'Northamptonshire', 'N'),
(830, 222, 'NUMB', 'Northumberland', 'N'),
(831, 222, 'NOTT', 'Nottinghamshire', 'N'),
(832, 222, 'OXFO', 'Oxfordshire', 'N'),
(833, 222, 'POWY', 'Powys', 'N'),
(834, 222, 'SHRO', 'Shropshire', 'N'),
(835, 222, 'SOME', 'Somerset', 'N'),
(836, 222, 'SYOR', 'South Yorkshire', 'N'),
(837, 222, 'STAF', 'Staffordshire', 'N'),
(838, 222, 'STRA', 'Strathclyde', 'N'),
(839, 222, 'SUFF', 'Suffolk', 'N'),
(840, 222, 'SURR', 'Surrey', 'N'),
(841, 222, 'WSUS', 'West Sussex', 'N'),
(842, 222, 'TAYS', 'Tayside', 'N'),
(843, 222, 'TYWE', 'Tyne &amp; Wear', 'N'),
(844, 222, 'WARW', 'Warwickshire', 'N'),
(845, 222, 'WISL', 'West Isles', 'N'),
(846, 222, 'WYOR', 'West Yorkshire', 'N'),
(847, 222, 'WILT', 'Wiltshire', 'N'),
(848, 10, '', 'Ciudad de Buenos Aires', 'N'),
(849, 10, '', 'Buenos Aires', 'N'),
(850, 10, '', 'Catamarca', 'N'),
(851, 10, '', 'Chaco', 'N'),
(852, 10, '', 'Chubut', 'N'),
(853, 10, '', 'C&oacute;rdoba', 'N'),
(854, 10, '', 'Corrientes', 'N'),
(855, 10, '', 'Entre R&iacute;os', 'N'),
(856, 10, '', 'Formosa', 'N'),
(857, 10, '', 'Jujuy', 'N'),
(858, 10, '', 'La Pampa', 'N'),
(859, 10, '', 'La Rioja', 'N'),
(860, 10, '', 'Mendoza', 'N'),
(861, 10, '', 'Misiones', 'N'),
(862, 10, '', 'Neuqu&eacute;n', 'N'),
(863, 10, '', '	R&iacute;o Negro', 'N'),
(864, 10, '', 'Salta', 'N'),
(865, 10, '', 'San Juan', 'N'),
(866, 10, '', 'San Luis', 'N'),
(867, 10, '', 'Santa Cruz', 'N'),
(868, 10, '', 'Santa Fe', 'N'),
(869, 10, '', 'Santiago del Estero', 'N'),
(870, 10, '', 'Tierra del Fuego', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE IF NOT EXISTS `recurso` (
  `nombre` varchar(20) NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `recurso`
--

INSERT INTO `recurso` (`nombre`, `descripcion`) VALUES
('alertaemails', ''),
('browser', ''),
('cargo', ''),
('catalogo', ''),
('categoria', ''),
('cliente', ''),
('clientetipo', ''),
('formadepago', ''),
('home', ''),
('index', ''),
('novedad', ''),
('productotextil', ''),
('talle', ''),
('talletipo', ''),
('usuario', ''),
('vendedor', ''),
('venta', ''),
('ventaestado', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos_por_perfil`
--

CREATE TABLE IF NOT EXISTS `recursos_por_perfil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perfil` varchar(200) NOT NULL,
  `recurso` varchar(200) NOT NULL,
  `privilegio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `privilegio` (`privilegio`),
  KEY `perfil` (`perfil`),
  KEY `recurso` (`recurso`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=127 ;

--
-- Volcado de datos para la tabla `recursos_por_perfil`
--

INSERT INTO `recursos_por_perfil` (`id`, `perfil`, `recurso`, `privilegio`) VALUES
(27, 'ADMIN', 'categoria', 'delete'),
(31, 'ADMIN', 'categoria', 'get'),
(32, 'ADMIN', 'categoria', 'put'),
(33, 'ADMIN', 'categoria', 'post'),
(43, 'ADMIN', 'index', 'authorize'),
(44, 'ADMIN', 'cliente', 'add'),
(45, 'ADMIN', 'cliente', 'avisonuevocliente'),
(46, 'ADMIN', 'productotextil', 'index'),
(47, 'ADMIN', 'productotextil', 'add'),
(48, 'ADMIN', 'browser', 'ajaxupload'),
(49, 'ADMIN', 'productotextil', 'edit'),
(50, 'GUEST', 'usuario', 'login'),
(51, 'ADMIN', 'index', 'index'),
(52, 'USER', 'index', 'logout'),
(53, 'USER', 'usuario', 'logout'),
(54, 'ADMIN', 'categoria', 'add'),
(55, 'ADMIN', 'categoria', 'edit'),
(56, 'ADMIN', 'categoria', 'list'),
(57, 'ADMIN', 'productotextil', 'list'),
(58, 'ADMIN', 'talle', 'add'),
(59, 'ADMIN', 'talle', 'edit'),
(60, 'ADMIN', 'talle', 'list'),
(61, 'ADMIN', 'productotextil', 'talleslist'),
(62, 'GUEST', 'home', 'index'),
(63, 'GUEST', 'home', 'condiciones'),
(64, 'GUEST', 'home', 'contact'),
(65, 'GUEST', 'home', 'index'),
(66, 'GUEST', 'home', 'login'),
(67, 'GUEST', 'home', 'register'),
(68, 'GUEST', 'home', 'invest'),
(69, 'ADMIN', 'productotextil', 'bloquear'),
(70, 'ADMIN', 'productotextil', 'desbloquear'),
(71, 'ADMIN', 'productotextil', 'savestock'),
(72, 'ADMIN', 'cliente', 'list'),
(73, 'ADMIN', 'clientetipo', 'list'),
(74, 'ADMIN', 'clientetipo', 'edit'),
(75, 'ADMIN', 'clientetipo', 'add'),
(76, 'ADMIN', 'cliente', 'edit'),
(77, 'ADMIN', 'venta', 'list'),
(78, 'ADMIN', 'formadepago', 'add'),
(79, 'ADMIN', 'formadepago', 'edit'),
(80, 'ADMIN', 'formadepago', 'list'),
(81, 'ADMIN', 'formadepago', 'index'),
(82, 'ADMIN', 'formadepago', 'delete'),
(83, 'ADMIN', 'vendedor', 'index'),
(84, 'ADMIN', 'vendedor', 'add'),
(85, 'ADMIN', 'vendedor', 'edit'),
(86, 'ADMIN', 'vendedor', 'delete'),
(87, 'ADMIN', 'ventaestado', 'index'),
(88, 'ADMIN', 'ventaestado', 'add'),
(89, 'ADMIN', 'ventaestado', 'edit'),
(90, 'ADMIN', 'ventaestado', 'delete'),
(91, 'ADMIN', 'alertaemails', 'index'),
(92, 'ADMIN', 'venta', 'avisonv'),
(93, 'ADMIN', 'novedad', 'admin'),
(94, 'ADMIN', 'novedad', 'edit'),
(95, 'ADMIN', 'browser', 'ajaxuploadnovedad'),
(96, 'ADMIN', 'venta', 'edit'),
(97, 'GUEST', 'catalogo', 'index'),
(98, 'GUEST', 'catalogo', 'producto'),
(99, 'ADMIN', 'catalogo', 'carrito'),
(100, 'USER', 'catalogo', 'carrito'),
(101, 'GUEST', 'catalogo', 'index'),
(102, 'GUEST', 'catalogo', 'producto'),
(103, 'USER', 'catalogo', 'getcarrito'),
(104, 'USER', 'catalogo', 'borrarcarrito'),
(105, 'USER', 'catalogo', 'confirmarcarrito'),
(106, 'GUEST', 'catalogo', 'categoria'),
(107, 'GUEST', 'catalogo', 'registro'),
(108, 'GUEST', 'usuario', 'validar'),
(109, 'GUEST', 'catalogo', 'validaremail'),
(110, 'GUEST', 'home', 'index'),
(111, 'GUEST', 'home', 'privacidad'),
(112, 'GUEST', 'home', 'contact'),
(113, 'GUEST', 'home', 'condiciones'),
(114, 'GUEST', 'home', 'register'),
(115, 'GUEST', 'index', 'index'),
(116, 'ADMIN', 'novedad', 'list'),
(117, 'GUEST', 'catalogo', 'novedades'),
(118, 'ADMIN', 'index', 'admin'),
(119, 'ADMIN', 'talletipo', 'index'),
(120, 'ADMIN', 'talletipo', 'add'),
(121, 'ADMIN', 'talletipo', 'edit'),
(122, 'ADMIN', 'talletipo', 'delete'),
(123, 'ADMIN', 'index', 'generatemodels'),
(124, 'GUEST', 'home', 'forgotpassword'),
(125, 'GUEST', 'home', 'reset'),
(126, 'GUEST', 'home', 'resetpassword');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `site_configuration`
--

CREATE TABLE IF NOT EXISTS `site_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) DEFAULT NULL,
  `nombre` varchar(200) NOT NULL,
  `template` varchar(200) NOT NULL,
  `estado` enum('ONLINE','OFFLINE') NOT NULL,
  `publicFolder` varchar(250) DEFAULT NULL,
  `subdominio` varchar(100) DEFAULT NULL,
  `baseclass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`subdominio`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `site_configuration`
--

INSERT INTO `site_configuration` (`id`, `app_id`, `nombre`, `template`, `estado`, `publicFolder`, `subdominio`, `baseclass`) VALUES
(1, '04f50f7dfc94e524e2fc6ce675663c1d', 'MottaCo', 'admin', 'ONLINE', '', 'motta', NULL),
(2, '221f67098b91c66830d0ec9b9305f510', 'Artesanias', 'admin', 'ONLINE', '', 'artesanias', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE IF NOT EXISTS `subcategoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `categoriaId` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `prioridad` tinyint(4) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `categoriaId` (`categoriaId`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`id`, `app_id`, `categoriaId`, `nombre`, `prioridad`, `borrado`) VALUES
(1, '', 1, 'Remera mangas cortas', 0, 'N'),
(2, '04f50f7dfc94e524e2fc6ce675663c1d', 1, 'Remera mangas cortas', 1, 'N'),
(3, '04f50f7dfc94e524e2fc6ce675663c1d', 1, 'Remeras mangas largas', 0, 'N'),
(4, '04f50f7dfc94e524e2fc6ce675663c1d', 1, 'Remeras mangas largas', 1, 'N'),
(5, '04f50f7dfc94e524e2fc6ce675663c1d', 1, 'Remera mangas cortinas', 8, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE IF NOT EXISTS `sucursal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `encargados` varchar(250) DEFAULT NULL,
  `telefono1` varchar(100) DEFAULT NULL,
  `telefono2` varchar(100) DEFAULT NULL,
  `observaciones` int(11) DEFAULT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`id`, `app_id`, `nombre`, `direccion`, `encargados`, `telefono1`, `telefono2`, `observaciones`, `borrado`) VALUES
(4, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(5, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(6, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(7, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(8, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(9, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(10, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(11, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(12, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(13, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(14, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(15, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(16, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(17, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(18, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(19, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N'),
(20, '36dd07ce38b167636f2b1fe96bb44ee6', 'suc 1', 'direccion', 'encar', 'tel', 'tel2', 0, 'N'),
(21, '36dd07ce38b167636f2b1fe96bb44ee6', 'nombre2', 'cucha cuahca2', 'encargado2', '234234234', '23423423', 0, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal_por_cliente`
--

CREATE TABLE IF NOT EXISTS `sucursal_por_cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cliente` (`id_cliente`,`id_sucursal`),
  KEY `id_sucursal` (`id_sucursal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Volcado de datos para la tabla `sucursal_por_cliente`
--

INSERT INTO `sucursal_por_cliente` (`id`, `id_cliente`, `id_sucursal`) VALUES
(17, 13, 20),
(18, 13, 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talle`
--

CREATE TABLE IF NOT EXISTS `talle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `prioridad` tinyint(4) NOT NULL,
  `id_tipo_talle` int(11) DEFAULT NULL,
  `talle` varchar(10000) DEFAULT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `tipotalle` (`id_tipo_talle`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Volcado de datos para la tabla `talle`
--

INSERT INTO `talle` (`id`, `app_id`, `prioridad`, `id_tipo_talle`, `talle`, `borrado`) VALUES
(1, '', 1, 2, 'XXS', 'N'),
(2, '', 2, 2, 'XS', 'N'),
(3, '', 3, 2, 'S', 'N'),
(4, '', 4, 2, 'M', 'N'),
(5, '', 5, 2, 'M', 'N'),
(6, '', 6, 2, 'XL', 'N'),
(7, '', 7, 2, 'XXL', 'N'),
(8, '', 8, 2, 'XXXL', 'N'),
(9, '', 1, 1, '22', 'N'),
(10, '', 2, 1, '23', 'N'),
(11, '', 3, 1, '24', 'N'),
(12, '', 4, 1, '25', 'N'),
(13, '', 5, 1, '26', 'N'),
(14, '', 6, 1, '27', 'N'),
(15, '', 7, 1, '28', 'N'),
(16, '', 8, 1, '29', 'N'),
(17, '', 9, 1, '30', 'N'),
(18, '', 10, 1, '31', 'N'),
(19, '', 11, 1, '32', 'N'),
(20, '', 12, 1, '33', 'N'),
(21, '', 13, 1, '34', 'N'),
(22, '', 14, 1, '35', 'N'),
(23, '', 15, 1, '36', 'N'),
(24, '', 16, 1, '37', 'N'),
(25, '', 17, 1, '38', 'N'),
(42, '36dd07ce38b167636f2b1fe96bb44ee6', 2, 2, 'M', 'N'),
(43, '36dd07ce38b167636f2b1fe96bb44ee6', 1, 2, 'S', 'N'),
(44, '36dd07ce38b167636f2b1fe96bb44ee6', 3, 2, 'L', 'N'),
(45, '36dd07ce38b167636f2b1fe96bb44ee6', 4, 2, 'XL', 'N'),
(46, '36dd07ce38b167636f2b1fe96bb44ee6', 5, 2, 'XXL', 'N'),
(47, '36dd07ce38b167636f2b1fe96bb44ee6', 1, 1, '23', 'N'),
(48, '36dd07ce38b167636f2b1fe96bb44ee6', 2, 1, '24', 'N'),
(49, '36dd07ce38b167636f2b1fe96bb44ee6', 3, 1, '25', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talle_por_producto_textil`
--

CREATE TABLE IF NOT EXISTS `talle_por_producto_textil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto_textil` int(11) NOT NULL,
  `id_talle` int(11) NOT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  `stock` int(11) DEFAULT NULL,
  `bloqueado_id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_producto_textil` (`id_producto_textil`,`id_talle`),
  KEY `id_talle` (`id_talle`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=274 ;

--
-- Volcado de datos para la tabla `talle_por_producto_textil`
--

INSERT INTO `talle_por_producto_textil` (`id`, `id_producto_textil`, `id_talle`, `borrado`, `stock`, `bloqueado_id_usuario`) VALUES
(84, 5, 43, 'N', 7, NULL),
(85, 5, 42, 'N', 6, NULL),
(86, 5, 44, 'N', 7, NULL),
(87, 5, 45, 'N', 8, NULL),
(88, 5, 46, 'N', 7, NULL),
(179, 6, 43, 'N', 5, NULL),
(180, 6, 42, 'N', 1, NULL),
(181, 6, 44, 'N', 2, NULL),
(182, 6, 45, 'N', 4, NULL),
(183, 6, 46, 'N', 5, NULL),
(191, 3, 44, 'N', 45, NULL),
(197, 7, 47, 'N', 1, NULL),
(198, 7, 48, 'N', 2, NULL),
(199, 7, 49, 'N', 2, NULL),
(225, 4, 43, 'N', 8, NULL),
(226, 4, 42, 'N', 0, NULL),
(227, 4, 44, 'N', 17, NULL),
(228, 4, 45, 'N', 11, NULL),
(229, 4, 46, 'N', 3, NULL),
(235, 2, 43, 'N', 8, NULL),
(236, 2, 42, 'N', 9, NULL),
(237, 2, 44, 'N', 3, NULL),
(238, 2, 45, 'N', 6, NULL),
(239, 2, 46, 'N', 8, NULL),
(255, 8, 47, 'N', 0, NULL),
(256, 8, 48, 'N', 39, NULL),
(257, 8, 49, 'N', 0, NULL),
(258, 3, 43, 'N', 3, NULL),
(259, 3, 42, 'N', 2, NULL),
(260, 3, 45, 'N', 1, NULL),
(261, 3, 46, 'N', 50, NULL),
(262, 1, 47, 'N', 4, NULL),
(263, 1, 48, 'N', 4, NULL),
(264, 1, 49, 'N', 1, NULL),
(265, 9, 47, 'N', 3, NULL),
(266, 9, 48, 'N', 3, NULL),
(267, 9, 49, 'N', 2, NULL),
(268, 10, 47, 'N', 4, NULL),
(269, 10, 48, 'N', 65, NULL),
(270, 10, 49, 'N', 44, NULL),
(271, 11, 47, 'N', 83, NULL),
(272, 11, 48, 'N', 63, NULL),
(273, 11, 49, 'N', 83, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talle_tipo`
--

CREATE TABLE IF NOT EXISTS `talle_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `descripcion` varchar(10000) DEFAULT NULL,
  `borrado` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `talle_tipo`
--

INSERT INTO `talle_tipo` (`id`, `app_id`, `descripcion`, `borrado`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'Numerico', 'N'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', 'Letras', 'N'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', 'pepito', 'Y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `apellido` varchar(200) DEFAULT NULL,
  `nick` varchar(20) NOT NULL,
  `facebookId` varchar(200) DEFAULT NULL,
  `twitterId` varchar(200) DEFAULT NULL,
  `googleId` varchar(200) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `perfil` varchar(200) NOT NULL,
  `alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `blockeado` enum('Y','N') NOT NULL DEFAULT 'Y',
  `validationHash` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `perfil` (`perfil`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=55 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `app_id`, `nombre`, `apellido`, `nick`, `facebookId`, `twitterId`, `googleId`, `password`, `email`, `perfil`, `alta`, `blockeado`, `validationHash`) VALUES
(40, '', 'Lider', 'Guitar', 'liderguitar', NULL, NULL, NULL, '473b82b81e33ec7a20dddaed1b1f5f33', NULL, 'SUPERADMIN', '2013-11-02 03:00:00', 'N', NULL),
(42, '36dd07ce38b167636f2b1fe96bb44ee6', 'Gustavo', 'pero', '', NULL, NULL, NULL, '61a447de1913596835acc818919f8218', 'liderguitar@gmail.com', 'ADMIN', '2014-01-09 13:19:23', 'N', 'cabaaf2e273cec141e9377c5bbcf2989'),
(43, '36dd07ce38b167636f2b1fe96bb44ee6', 'Pepito', 'Gimenez', '', NULL, NULL, NULL, '61a447de1913596835acc818919f8218', 'pepito@gmail.com', 'ADMIN', '2014-09-08 13:38:16', 'N', 'c8f980282c50c4cf665cde551db7db37'),
(51, 'c96bd135ae37d6153418d5dd766f9d70', 'ppemm', 'sanchez', '', NULL, NULL, NULL, '61a447de1913596835acc818919f8218', 'liderguitaeerwerr@gmail.com', 'ADMIN', '2015-02-05 17:19:05', 'N', 'e6c988c5b02404c4840f6106dcae7c63'),
(54, 'f50863d2cc199ac104dbdf601b5bd3fd', 'gustavo', 'pero', '', NULL, NULL, NULL, '473b82b81e33ec7a20dddaed1b1f5f33', 'gustavopero@yahoo.com.ar', 'ADMIN', '2015-04-17 01:05:39', 'N', '68b39a54ae569395f66003876990e905');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE IF NOT EXISTS `vendedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `app_id` varchar(50) NOT NULL,
  `id_usuario` varchar(40) NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') NOT NULL DEFAULT 'INACTIVO',
  `borrado` enum('N','Y') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `vendedor`
--

INSERT INTO `vendedor` (`id`, `nombre`, `app_id`, `id_usuario`, `estado`, `borrado`) VALUES
(1, 'jose pepe sanfilipo 2', '36dd07ce38b167636f2b1fe96bb44ee6', '1234', 'ACTIVO', 'N'),
(2, 'Pablo Neruda', '36dd07ce38b167636f2b1fe96bb44ee6', '1234', 'INACTIVO', 'N'),
(3, 'Vendedor 3', '36dd07ce38b167636f2b1fe96bb44ee6', '', 'ACTIVO', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE IF NOT EXISTS `venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clienteId` int(11) NOT NULL,
  `vendedorId` int(11) DEFAULT NULL,
  `ventaEstadoId` int(11) NOT NULL,
  `formaDePagoId` int(11) NOT NULL,
  `formaDePagoPorc` decimal(8,2) DEFAULT NULL,
  `borrado` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `clienteId` (`clienteId`,`ventaEstadoId`,`formaDePagoId`),
  KEY `clienteId_2` (`clienteId`),
  KEY `ventaEstadoId_2` (`ventaEstadoId`),
  KEY `vendedorId` (`vendedorId`),
  KEY `fghfgh` (`ventaEstadoId`),
  KEY `formaDePagoId` (`formaDePagoId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=52 ;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id`, `app_id`, `fecha`, `clienteId`, `vendedorId`, `ventaEstadoId`, `formaDePagoId`, `formaDePagoPorc`, `borrado`) VALUES
(50, '36dd07ce38b167636f2b1fe96bb44ee6', '2015-01-26 23:00:53', 14, NULL, 2, 3, -3.00, 'N'),
(51, '36dd07ce38b167636f2b1fe96bb44ee6', '2015-01-27 14:03:19', 14, NULL, 4, 4, 10.00, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalle`
--

CREATE TABLE IF NOT EXISTS `venta_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ventaId` int(11) NOT NULL,
  `productoTextilId` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precioUnitario` decimal(8,2) NOT NULL,
  `tallePorProductoTextil` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ventaId` (`ventaId`,`productoTextilId`),
  KEY `ventaId_2` (`ventaId`),
  KEY `productoId` (`productoTextilId`),
  KEY `tallePorProductoTextil` (`tallePorProductoTextil`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Volcado de datos para la tabla `venta_detalle`
--

INSERT INTO `venta_detalle` (`id`, `ventaId`, `productoTextilId`, `cantidad`, `precioUnitario`, `tallePorProductoTextil`) VALUES
(10, 50, 11, 1, 100.00, 271),
(11, 50, 11, 1, 100.00, 272),
(12, 50, 11, 1, 100.00, 273),
(13, 50, 7, 1, 150.00, 197),
(14, 50, 7, 1, 150.00, 198),
(15, 50, 7, 1, 150.00, 199),
(16, 50, 2, 1, 150.00, 236),
(17, 50, 2, 1, 150.00, 237),
(18, 50, 2, 1, 150.00, 238),
(19, 50, 2, 1, 150.00, 239),
(20, 51, 2, 1, 150.00, 235),
(21, 51, 2, 1, 150.00, 237),
(22, 51, 2, 1, 150.00, 239),
(23, 51, 7, 1, 150.00, 197),
(24, 51, 7, 1, 150.00, 198),
(25, 51, 7, 1, 150.00, 199);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_estado`
--

CREATE TABLE IF NOT EXISTS `venta_estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `devuelveStock` enum('Y','N') NOT NULL,
  `cancelado` enum('Y','N') DEFAULT 'N',
  `borrado` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `venta_estado`
--

INSERT INTO `venta_estado` (`id`, `app_id`, `nombre`, `devuelveStock`, `cancelado`, `borrado`) VALUES
(1, '36dd07ce38b167636f2b1fe96bb44ee6', 'Pagado y Pendiente de Entrega', 'N', 'N', 'N'),
(2, '36dd07ce38b167636f2b1fe96bb44ee6', 'Pendiente de Pago y Entrega', 'N', 'N', 'N'),
(3, '36dd07ce38b167636f2b1fe96bb44ee6', 'Pagado y Entregado', 'N', 'N', 'Y'),
(4, '36dd07ce38b167636f2b1fe96bb44ee6', 'Cancelado', 'Y', 'Y', 'N');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `cliente_tipo` (`id`),
  ADD CONSTRAINT `cliente_ibfk_3` FOREIGN KEY (`provincia_id`) REFERENCES `provincia` (`id`),
  ADD CONSTRAINT `cliente_ibfk_4` FOREIGN KEY (`estado_id`) REFERENCES `cliente_estado` (`id`);

--
-- Filtros para la tabla `comentario_por_cliente`
--
ALTER TABLE `comentario_por_cliente`
  ADD CONSTRAINT `cl` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `cm` FOREIGN KEY (`id_comentario`) REFERENCES `comentario` (`id`);

--
-- Filtros para la tabla `fotos_por_producto`
--
ALTER TABLE `fotos_por_producto`
  ADD CONSTRAINT `fotos_por_producto_ibfk_1` FOREIGN KEY (`id_foto`) REFERENCES `foto` (`id`),
  ADD CONSTRAINT `fotos_por_producto_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`);

--
-- Filtros para la tabla `menu_item`
--
ALTER TABLE `menu_item`
  ADD CONSTRAINT `menu_item_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`);

--
-- Filtros para la tabla `pedido_detalle_por_talle`
--
ALTER TABLE `pedido_detalle_por_talle`
  ADD CONSTRAINT `pedido_detalle_por_talle_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `pedido_detalle_por_talle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `pedido_detalle_por_talle_ibfk_3` FOREIGN KEY (`id_talle`) REFERENCES `talle` (`id`);

--
-- Filtros para la tabla `personal_por_cliente`
--
ALTER TABLE `personal_por_cliente`
  ADD CONSTRAINT `personal_por_cliente_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `personal_por_cliente_ibfk_2` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_subcategoria`) REFERENCES `categoria` (`id`);

--
-- Filtros para la tabla `producto_textil`
--
ALTER TABLE `producto_textil`
  ADD CONSTRAINT `producto_textil_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `producto_textil_ibfk_2` FOREIGN KEY (`talle_tipo_id`) REFERENCES `talle_tipo` (`id`);

--
-- Filtros para la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD CONSTRAINT `provincia_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id`);

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `subcategoria_ibfk_1` FOREIGN KEY (`categoriaId`) REFERENCES `categoria` (`id`);

--
-- Filtros para la tabla `sucursal_por_cliente`
--
ALTER TABLE `sucursal_por_cliente`
  ADD CONSTRAINT `sucursal_por_cliente_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id`),
  ADD CONSTRAINT `sucursal_por_cliente_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`);

--
-- Filtros para la tabla `talle`
--
ALTER TABLE `talle`
  ADD CONSTRAINT `talle_ibfk_1` FOREIGN KEY (`id_tipo_talle`) REFERENCES `talle_tipo` (`id`);

--
-- Filtros para la tabla `talle_por_producto_textil`
--
ALTER TABLE `talle_por_producto_textil`
  ADD CONSTRAINT `talle_por_producto_textil_ibfk_1` FOREIGN KEY (`id_producto_textil`) REFERENCES `producto_textil` (`id`),
  ADD CONSTRAINT `talle_por_producto_textil_ibfk_2` FOREIGN KEY (`id_talle`) REFERENCES `talle` (`id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`perfil`) REFERENCES `perfil` (`nombre`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`clienteId`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`ventaEstadoId`) REFERENCES `venta_estado` (`id`),
  ADD CONSTRAINT `venta_ibfk_4` FOREIGN KEY (`vendedorId`) REFERENCES `vendedor` (`id`),
  ADD CONSTRAINT `venta_ibfk_5` FOREIGN KEY (`formaDePagoId`) REFERENCES `pago_tipo` (`id`);

--
-- Filtros para la tabla `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD CONSTRAINT `venta_detalle_ibfk_1` FOREIGN KEY (`ventaId`) REFERENCES `venta` (`id`),
  ADD CONSTRAINT `venta_detalle_ibfk_2` FOREIGN KEY (`productoTextilId`) REFERENCES `producto_textil` (`id`),
  ADD CONSTRAINT `venta_detalle_ibfk_3` FOREIGN KEY (`tallePorProductoTextil`) REFERENCES `talle_por_producto_textil` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
