-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12-Abr-2023 às 03:28
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pesagem`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `nome`) VALUES
(1, 'ASFALTO'),
(2, 'PEDRAS'),
(3, 'ALIMENTOS');

-- --------------------------------------------------------

--
-- Estrutura da tabela `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nome_fantasia` varchar(45) DEFAULT NULL,
  `razao_social` varchar(45) DEFAULT NULL,
  `cnpj` varchar(45) DEFAULT NULL,
  `endereco` varchar(45) DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `motoristas`
--

CREATE TABLE `motoristas` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `sobrenome` varchar(45) DEFAULT NULL,
  `endereco` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `cpf` varchar(45) DEFAULT NULL,
  `rg` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `motoristas`
--

INSERT INTO `motoristas` (`id`, `nome`, `sobrenome`, `endereco`, `telefone`, `cpf`, `rg`) VALUES
(6, 'LEARCINDO', 'LOPES', 'CAMPOS NOVOS', '8989898', '8989892656', '565656'),
(7, 'JOÃO', 'VALDERI PINTO', 'CAMPOS NOVOS', '56454654654', '4654654646', '121251132');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pesagens`
--

CREATE TABLE `pesagens` (
  `id` int(11) NOT NULL,
  `placa` int(11) DEFAULT NULL,
  `carreta` int(11) DEFAULT NULL,
  `motorista` int(11) DEFAULT NULL,
  `data_entrada` date DEFAULT NULL,
  `data_saida` date DEFAULT NULL,
  `hora_entrada` date DEFAULT NULL,
  `hora_saida` date DEFAULT NULL,
  `obs` text DEFAULT NULL,
  `cliente` int(11) DEFAULT NULL,
  `fornecedor` int(11) DEFAULT NULL,
  `transportadora` int(11) DEFAULT NULL,
  `produto` int(11) DEFAULT NULL,
  `peso_tara` double(8,2) DEFAULT NULL,
  `peso_bruto` double(8,2) DEFAULT NULL,
  `peso_liquido` double(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `placas`
--

CREATE TABLE `placas` (
  `id` int(11) NOT NULL,
  `placa` varchar(45) NOT NULL,
  `tipo_veiculo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `placas`
--

INSERT INTO `placas` (`id`, `placa`, `tipo_veiculo`) VALUES
(14, 'MDR8590', 1),
(15, 'DSF9I69', 1),
(16, 'MAE0169', 1),
(17, 'KLN3C18', 1),
(18, 'SDSD', 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `categoria` int(11) DEFAULT NULL,
  `marca` int(11) DEFAULT NULL,
  `unidade_medida` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `categoria`, `marca`, `unidade_medida`) VALUES
(1, 'CAP 50-70', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_empresa`
--

CREATE TABLE `tipo_empresa` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_veiculo`
--

CREATE TABLE `tipo_veiculo` (
  `id` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tipo_veiculo`
--

INSERT INTO `tipo_veiculo` (`id`, `descricao`) VALUES
(1, 'CAMINHÃO BASCULANTE'),
(2, 'CARRO DE PASSEIO'),
(3, 'CARRO UTILITÁRIO'),
(4, 'CAMINHÃO TANQUE');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `motoristas`
--
ALTER TABLE `motoristas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `pesagens`
--
ALTER TABLE `pesagens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_placa_id` (`placa`),
  ADD KEY `fk_carreta_id` (`carreta`),
  ADD KEY `fk_motorista_id` (`motorista`),
  ADD KEY `fk_transportadora_id` (`transportadora`),
  ADD KEY `fk_produto_id` (`produto`),
  ADD KEY `fk_fornecedor_id` (`fornecedor`),
  ADD KEY `fk_cliente_id` (`cliente`);

--
-- Índices para tabela `placas`
--
ALTER TABLE `placas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tipo_empresa`
--
ALTER TABLE `tipo_empresa`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tipo_veiculo`
--
ALTER TABLE `tipo_veiculo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `motoristas`
--
ALTER TABLE `motoristas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `pesagens`
--
ALTER TABLE `pesagens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `placas`
--
ALTER TABLE `placas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tipo_empresa`
--
ALTER TABLE `tipo_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipo_veiculo`
--
ALTER TABLE `tipo_veiculo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `pesagens`
--
ALTER TABLE `pesagens`
  ADD CONSTRAINT `fk_carreta_id` FOREIGN KEY (`carreta`) REFERENCES `placas` (`id`),
  ADD CONSTRAINT `fk_cliente_id` FOREIGN KEY (`cliente`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_fornecedor_id` FOREIGN KEY (`fornecedor`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_motorista_id` FOREIGN KEY (`motorista`) REFERENCES `motoristas` (`id`),
  ADD CONSTRAINT `fk_placa_id` FOREIGN KEY (`placa`) REFERENCES `placas` (`id`),
  ADD CONSTRAINT `fk_produto_id` FOREIGN KEY (`produto`) REFERENCES `produtos` (`id`),
  ADD CONSTRAINT `fk_transportadora_id` FOREIGN KEY (`transportadora`) REFERENCES `empresas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
