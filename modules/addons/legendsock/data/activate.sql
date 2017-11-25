-- Soft Name: LegendSock
-- Current version: 2.1
-- https://www.legendsock.com

CREATE TABLE IF NOT EXISTS `ls_cache` (
  `id` int(11) NOT NULL,
  `setting` longtext NOT NULL,
  `value` longtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

INSERT INTO `ls_cache` (`id`, `setting`, `value`) VALUES
(1, 'traffic', '0'),
(2, 'product', '0');

CREATE TABLE IF NOT EXISTS `ls_setting` (
  `sid` int(11) NOT NULL,
  `node` longtext NOT NULL,
  `notice` longtext NOT NULL,
  `resource` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `ls_cache`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `ls_setting`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `sid` (`sid`);

ALTER TABLE `ls_cache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;