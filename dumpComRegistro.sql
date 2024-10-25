-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 25/10/2024 às 16:13
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

--
-- Despejando dados para a tabela `tbclientes`
--

INSERT INTO `tbclientes` (`CODIGO`, `NOME`, `CIDADE`, `UF`) VALUES
(1, 'João Silva', 'São Paulo', 'SP'),
(2, 'Maria Souza', 'Rio de Janeiro', 'RJ'),
(3, 'Carlos Pereira', 'Belo Horizonte', 'MG'),
(4, 'Ana Lima', 'Curitiba', 'PR'),
(5, 'Paulo Mendes', 'Porto Alegre', 'RS'),
(6, 'Mariana Oliveira', 'Salvador', 'BA'),
(7, 'Lucas Almeida', 'Fortaleza', 'CE'),
(8, 'Fernanda Costa', 'Manaus', 'AM'),
(9, 'Roberto Gomes', 'Brasília', 'DF'),
(10, 'Beatriz Ribeiro', 'Recife', 'PE'),
(11, 'Guilherme Fernandes', 'Belém', 'PA'),
(12, 'Isabela Martins', 'Goiânia', 'GO'),
(13, 'Pedro Lima', 'São Luís', 'MA'),
(14, 'Larissa Freitas', 'Natal', 'RN'),
(15, 'Rafael Duarte', 'João Pessoa', 'PB'),
(16, 'Cíntia Castro', 'Aracaju', 'SE'),
(17, 'Fábio Cardoso', 'Maceió', 'AL'),
(18, 'Vanessa Pinto', 'Teresina', 'PI'),
(19, 'Tiago Rocha', 'Campo Grande', 'MS'),
(20, 'Cláudia Neves', 'Cuiabá', 'MT');

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

--
-- Despejando dados para a tabela `tbitenspedidos`
--

INSERT INTO `tbitenspedidos` (`CODIGO`, `CODIGO_PEDIDO`, `COD_PRODUTO`, `QUANT`, `VLR_UNIT`, `VLR_TOTAL`) VALUES
(7, 7, 18, 1, 39.9, 39.9),
(8, 7, 6, 1, 3999, 3999),
(13, 6, 16, 1, 159.9, 159.9),
(14, 6, 9, 10, 199, 1990);

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

--
-- Despejando dados para a tabela `tbpedidos`
--

INSERT INTO `tbpedidos` (`CODIGO_PEDIDO`, `DT_EMISSAO`, `COD_CLI`, `VLR_TOTAL`) VALUES
(6, '2024-10-24', 15, 2149.9),
(7, '2024-10-25', 3, 4038.9);

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
-- Despejando dados para a tabela `tbprodutos`
--

INSERT INTO `tbprodutos` (`CODIGO`, `DESCRICAO`, `PRECO`) VALUES
(1, 'Cadeira de Escritório', 499.99),
(2, 'Mesa de Computador', 299.9),
(3, 'Monitor LED 24 Polegadas', 899.9),
(4, 'Teclado Mecânico', 199.99),
(5, 'Mouse Gamer', 149.5),
(6, 'Notebook 15.6\"', 3999),
(7, 'Smartphone 128GB', 2499.99),
(8, 'Headset Gamer', 329),
(9, 'Webcam Full HD', 199),
(10, 'Impressora Multifuncional', 599.99),
(11, 'SSD 1TB', 549.9),
(12, 'Placa de Vídeo 4GB', 1299),
(13, 'Fonte 500W', 229.9),
(14, 'Memória RAM 16GB', 499),
(15, 'Gabinete Gamer', 349.9),
(16, 'Carregador Portátil 10000mAh', 159.9),
(17, 'Roteador Wi-Fi 6', 459),
(18, 'Cabo HDMI 2m', 39.9),
(19, 'Hub USB 3.0', 89.9),
(20, 'Adaptador USB-C', 49.99);

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
  MODIFY `CODIGO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `tbitenspedidos`
--
ALTER TABLE `tbitenspedidos`
  MODIFY `CODIGO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `tbpedidos`
--
ALTER TABLE `tbpedidos`
  MODIFY `CODIGO_PEDIDO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `tbprodutos`
--
ALTER TABLE `tbprodutos`
  MODIFY `CODIGO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
