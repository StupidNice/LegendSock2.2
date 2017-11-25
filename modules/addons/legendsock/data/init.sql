-- Soft Name: LegendSock
-- Current version: 2.1
-- https://www.legendsock.com

CREATE TABLE IF NOT EXISTS `chart` (
  `pid` int(11) NOT NULL,
  `upload` text NOT NULL,
  `download` text NOT NULL,
  `date` int(11) NOT NULL DEFAULT '1475769600'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `setting` (
  `pid` int(11) NOT NULL,
  `mail` tinyint(4) NOT NULL DEFAULT '0',
  `addition` bigint(20) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '1475769600'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user` (
  `pid` int(11) NOT NULL,
  `u` bigint(20) NOT NULL DEFAULT '0',
  `d` bigint(20) NOT NULL DEFAULT '0',
  `t` int(11) NOT NULL DEFAULT '1475769600',
  `port` int(11) NOT NULL DEFAULT '0',
  `obfs` varchar(128) NOT NULL DEFAULT 'plain',
  `method` varchar(64) NOT NULL DEFAULT 'aes-256-cfb',
  `protocol` varchar(128) NOT NULL DEFAULT 'origin',
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  `passwd` varchar(64) NOT NULL,
  `transfer_enable` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `chart`
  ADD PRIMARY KEY (`pid`),
  ADD UNIQUE KEY `pid` (`pid`);

ALTER TABLE `setting`
  ADD PRIMARY KEY (`pid`),
  ADD UNIQUE KEY `pid` (`pid`);

ALTER TABLE `user`
  ADD PRIMARY KEY (`pid`),
  ADD UNIQUE KEY `pid` (`pid`),
  ADD UNIQUE KEY `port` (`port`);