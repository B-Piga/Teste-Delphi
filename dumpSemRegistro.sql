-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 25/10/2024 às 16:18
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `testevenda`
--
CREATE DATABASE IF NOT EXISTS `testevenda` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `testevenda`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbclientes`
--

DROP TABLE IF EXISTS `tbclientes`;
CREATE TABLE `tbclientes` (
  `CODIGO` int(11) NOT NULL,
  `NOME` varchar(60) NOT NULL,
  `CIDADE` varchar(60) NOT NULL,
  `UF` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbitenspedidos`
--

DROP TABLE IF EXISTS `tbitenspedidos`;
CREATE TABLE `tbitenspedidos` (
  `CODIGO` int(11) NOT NULL,
  `CODIGO_PEDIDO` int(11) NOT NULL,
  `COD_PRODUTO` int(11) NOT NULL,
  `QUANT` float NOT NULL,
  `VLR_UNIT` float NOT NULL,
  `VLR_TOTAL` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbpedidos`
--

DROP TABLE IF EXISTS `tbpedidos`;
CREATE TABLE `tbpedidos` (
  `CODIGO_PEDIDO` int(11) NOT NULL,
  `DT_EMISSAO` date NOT NULL DEFAULT current_timestamp(),
  `COD_CLI` int(11) NOT NULL,
  `VLR_TOTAL` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbprodutos`
--

DROP TABLE IF EXISTS `tbprodutos`;
CREATE TABLE `tbprodutos` (
  `CODIGO` int(11) NOT NULL,
  `DESCRICAO` varchar(60) NOT NULL,
  `PRECO` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tbclientes`
--
ALTER TABLE `tbclientes`
  ADD PRIMARY KEY (`CODIGO`),
  ADD KEY `idx_nome` (`NOME`);

--
-- Índices de tabela `tbitenspedidos`
--
ALTER TABLE `tbitenspedidos`
  ADD PRIMARY KEY (`CODIGO`),
  ADD KEY `fk_codigo_produto` (`COD_PRODUTO`);

--
-- Índices de tabela `tbpedidos`
--
ALTER TABLE `tbpedidos`
  ADD PRIMARY KEY (`CODIGO_PEDIDO`),
  ADD KEY `fk_codigo_cliente` (`COD_CLI`);

--
-- Índices de tabela `tbprodutos`
--
ALTER TABLE `tbprodutos`
  ADD PRIMARY KEY (`CODIGO`),
  ADD KEY `idx_descricao` (`DESCRICAO`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tbclientes`
--
ALTER TABLE `tbclientes`
  MODIFY `CODIGO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tbitenspedidos`
--
ALTER TABLE `tbitenspedidos`
  MODIFY `CODIGO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tbpedidos`
--
ALTER TABLE `tbpedidos`
  MODIFY `CODIGO_PEDIDO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tbprodutos`
--
ALTER TABLE `tbprodutos`
  MODIFY `CODIGO` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tbitenspedidos`
--
ALTER TABLE `tbitenspedidos`
  ADD CONSTRAINT `fk_codigo_produto` FOREIGN KEY (`COD_PRODUTO`) REFERENCES `tbprodutos` (`CODIGO`);

--
-- Restrições para tabelas `tbpedidos`
--
ALTER TABLE `tbpedidos`
  ADD CONSTRAINT `fk_codigo_cliente` FOREIGN KEY (`COD_CLI`) REFERENCES `tbclientes` (`CODIGO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
