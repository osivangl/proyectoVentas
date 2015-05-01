-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 25-10-2013 a las 18:29:44
-- Versión del servidor: 5.5.25
-- Versión de PHP: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `demo_mvc`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `actualizar_empleado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_empleado`(   IN nombreParam varchar(30),
    IN apePaternoParam varchar(30),
    IN apeMaternoParam varchar(30),
    IN sexoParam bit,
    IN departamentoIdParam int(11),
    IN idParam int(11) )
BEGIN
	update empleado 
        set nombre = nombreParam, 
            ape_paterno = apePaternoParam, 
            ape_materno = apeMaternoParam,
            sexo = sexoParam, 
            departamento_id = departamentoIdParam 
    where id = idParam;
END$$

DROP PROCEDURE IF EXISTS `borrar_empleado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_empleado`(   IN idParam int(11),
    OUT resParam bit )
BEGIN
	delete from empleado where id = idParam;
    set resParam = 1;
END$$

DROP PROCEDURE IF EXISTS `buscar_departamentos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_departamentos`()
BEGIN
	SELECT id, nombre from departamento;
END$$

DROP PROCEDURE IF EXISTS `buscar_empleado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_empleado`(IN idParam INT)
BEGIN
	SELECT e.id, e.nombre, e.ape_paterno, e.ape_materno, e.sexo, e.departamento_id
    from empleado e where e.id = idParam;
END$$

DROP PROCEDURE IF EXISTS `buscar_empleados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_empleados`()
BEGIN
	SELECT e.id, e.nombre, e.ape_paterno, e.ape_materno, e.sexo,
    d.id as departamento_id, d.nombre as depto
    from empleado e inner join departamento d on e.departamento_id = d.id;
END$$

DROP PROCEDURE IF EXISTS `insertar_empleado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_empleado`(IN `nombreParam` VARCHAR(30), IN `apePaternoParam` VARCHAR(30), IN `apeMaternoParam` VARCHAR(30), IN `sexoParam` INT(11), IN `departamentoIdParam` INT(11))
    NO SQL
INSERT INTO empleado( nombre, ape_paterno, ape_materno, sexo, departamento_id ) 
VALUES (
nombreParam, apePaternoParam, apeMaternoParam, sexoParam, departamentoIdParam
)$$

DROP PROCEDURE IF EXISTS `validar_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validar_login`(IN emailParam VARCHAR(50), IN passwordParam VARCHAR(50))
BEGIN
	SELECT id, email from usuario where email = emailParam and password = passwordParam;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

DROP TABLE IF EXISTS `departamento`;
CREATE TABLE IF NOT EXISTS `departamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id`, `nombre`) VALUES
(1, 'Mantenimiento'),
(2, 'Tesorería'),
(3, 'Dirección'),
(4, 'Recursos humanos'),
(5, 'CSI'),
(6, 'Escolar'),
(7, 'Compras');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `ape_paterno` varchar(30) NOT NULL,
  `ape_materno` varchar(30) DEFAULT NULL,
  `sexo` int(1) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_emp_depto` (`departamento_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id`, `nombre`, `ape_paterno`, `ape_materno`, `sexo`, `departamento_id`) VALUES
(1, 'Jesus Eduardo', 'Hernandez', 'Perez', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `email`, `password`) VALUES
(1, 'carlos@hotmail.com', '123456');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `fk_emp_depto` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
