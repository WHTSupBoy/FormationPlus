-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 27 juil. 2021 à 01:41
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `formationplus`
--

-- --------------------------------------------------------

--
-- Structure de la table `attestation`
--

CREATE TABLE `attestation` (
  `id` int(11) NOT NULL,
  `etudiant_id` int(11) DEFAULT NULL,
  `convention_id` int(11) DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `attestation`
--

INSERT INTO `attestation` (`id`, `etudiant_id`, `convention_id`, `message`) VALUES
(1, 20, 8, '');

-- --------------------------------------------------------

--
-- Structure de la table `convention`
--

CREATE TABLE `convention` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nb_heur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `convention`
--

INSERT INTO `convention` (`id`, `nom`, `nb_heur`) VALUES
(1, '-', 0),
(6, 'Géomètre du cadastre', 251),
(7, 'Ramasseur d\'endives', 212),
(8, 'Mouleur sable', 377),
(9, 'Commis de coupe', 369),
(10, 'Géomètre du cadastre', 187);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20210726124639', '2021-07-26 14:46:53', 128);

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `id` int(11) NOT NULL,
  `convention_id` int(11) DEFAULT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id`, `convention_id`, `nom`, `prenom`, `mail`) VALUES
(16, 6, 'Normand', 'Philippe', 'luc76@payet.fr'),
(17, 8, 'Hardy', 'Éléonore', 'schneider.robert@rossi.fr'),
(18, 9, 'Goncalves', 'Mathilde', 'adelaide72@pottier.com'),
(19, 8, 'Fontaine', 'Caroline', 'bernard.berthelot@bazin.fr'),
(20, 8, 'Fouquet', 'Alexandre', 'vrenaud@faure.com'),
(21, 7, 'Delannoy', 'Joséphine', 'thomas.diane@dupont.fr'),
(22, 7, 'Laporte', 'Augustin', 'eugene.duhamel@bonnet.fr'),
(23, 7, 'Mace', 'Brigitte', 'hugues.boulay@torres.net'),
(24, 7, 'Marchand', 'Roland', 'apons@noos.fr'),
(25, 9, 'Ledoux', 'Victor', 'olivier10@orange.fr'),
(26, 10, 'Fleury', 'Laurent', 'remy10@dumas.fr'),
(27, 6, 'Meunier', 'François', 'caroline.pruvost@sfr.fr'),
(28, 6, 'Jean', 'Roland', 'lefebvre.susan@durand.fr'),
(29, 8, 'Vincent', 'Élisabeth', 'eric.aubert@noos.fr'),
(30, 7, 'Blin', 'Jacqueline', 'corinne69@gmail.com');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `attestation`
--
ALTER TABLE `attestation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_326EC63FDDEAB1A3` (`etudiant_id`),
  ADD UNIQUE KEY `UNIQ_326EC63FA2ACEBCC` (`convention_id`);

--
-- Index pour la table `convention`
--
ALTER TABLE `convention`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_717E22E3A2ACEBCC` (`convention_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `attestation`
--
ALTER TABLE `attestation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `convention`
--
ALTER TABLE `convention`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `attestation`
--
ALTER TABLE `attestation`
  ADD CONSTRAINT `FK_326EC63FA2ACEBCC` FOREIGN KEY (`convention_id`) REFERENCES `convention` (`id`),
  ADD CONSTRAINT `FK_326EC63FDDEAB1A3` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `FK_717E22E3A2ACEBCC` FOREIGN KEY (`convention_id`) REFERENCES `convention` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
