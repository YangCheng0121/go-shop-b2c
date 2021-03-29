/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : go-shop-b2c

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 23/03/2021 17:35:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ad
-- ----------------------------
DROP TABLE IF EXISTS `ad`;
CREATE TABLE `ad`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `type` int(11) NOT NULL COMMENT '类型',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `ad_position_id` bigint(20) NOT NULL COMMENT '广告位',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '路径',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接地址',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '起始日期',
  `end_date` datetime NULL DEFAULT NULL COMMENT '结束日期',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK6D301C2E947C2F5`(`ad_position_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ad
-- ----------------------------

-- ----------------------------
-- Table structure for ad_position
-- ----------------------------
DROP TABLE IF EXISTS `ad_position`;
CREATE TABLE `ad_position`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `height` int(11) NOT NULL COMMENT '高度',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `template` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板',
  `width` int(11) NOT NULL COMMENT '宽度',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告位' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ad_position
-- ----------------------------
INSERT INTO `ad_position` VALUES (1, NULL, 50, '头部广告', '<div class=\"headerAd\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n				</a>\r\n			[#else]\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 320, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (2, NULL, 52, '底部广告', '<div class=\"footerAd\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n				</a>\r\n			[#else]\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 950, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (3, NULL, 290, '首页轮播广告', '<div id=\"slider\" class=\"slider\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n				</a>\r\n			[#else]\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 770, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (4, NULL, 106, '首页右侧广告', '<div class=\"rightAd\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n				</a>\r\n			[#else]\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 230, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (5, NULL, 120, '首页中部广告', '<div class=\"middleAd\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n				</a>\r\n			[#else]\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 1000, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (6, NULL, 343, '首页热门商品左则广告', '[#list adPosition.ads as ad]\r\n	[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n		[#if ad.url??]\r\n			<a href=\"${ad.url}\">\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			</a>\r\n		[#else]\r\n			<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n		[/#if]\r\n	[/#if]\r\n[/#list]', 260, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (7, NULL, 343, '首页最新商品左则广告', '[#list adPosition.ads as ad]\r\n	[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n		[#if ad.url??]\r\n			<a href=\"${ad.url}\">\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			</a>\r\n		[#else]\r\n			<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n		[/#if]\r\n	[/#if]\r\n[/#list]', 260, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (8, NULL, 300, '会员注册右侧广告', '<div class=\"ad\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"text\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					${ad.content}\r\n				</a>\r\n			[#else]\r\n				${ad.content}\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 240, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ad_position` VALUES (9, NULL, 330, '会员登录左侧广告', '<div class=\"ad\">\r\n	[#list adPosition.ads as ad]\r\n		[#if ad.hasBegun() && !ad.hasEnded() && ad.type == \"image\"]\r\n			[#if ad.url??]\r\n				<a href=\"${ad.url}\">\r\n					<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n				</a>\r\n			[#else]\r\n				<img src=\"${ad.path}\" width=\"${adPosition.width}\" height=\"${adPosition.height}\" alt=\"${ad.title}\" title=\"${ad.title}\" />\r\n			[/#if]\r\n		[/#if]\r\n	[/#list]\r\n</div>', 500, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `hasher` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '加密类型',
  `salt` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '加密盐',
  `department` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'E-mail',
  `is_enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `is_locked` tinyint(1) NOT NULL COMMENT '是否锁定',
  `locked_date` datetime NULL DEFAULT NULL COMMENT '锁定日期',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录日期',
  `login_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登录IP ',
  `login_failure_count` int(11) NOT NULL COMMENT '连续登录失败次数',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 765446407850164269 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (765446407850164268, '管理员', 'admin', 'GcNOch19UvCMB9oErkiv1YA-W6wfeR8RJ97Ym5mUG4a8XhSgjeAqQYhyJB2ZU85j0EQS|15|43d09b804a46e845a70008494dfe6ff2b792b902e19a0d9c573c2ca5|c3ce3e54fc9c042e8ff76f31c5d4e939ce5f273c25463aa93fc1fb2a3ff06e76', '', '', '', 'yang759126596@163.com', 1, 0, NULL, '2021-03-11 09:30:19', '14.213.30.34', 0, '', '2021-01-22 09:47:45', '', '2021-03-11 09:30:19', 0);

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role`  (
  `admins` bigint(20) NOT NULL,
  `roles` bigint(20) NOT NULL COMMENT '角色',
  PRIMARY KEY (`admins`, `roles`) USING BTREE,
  INDEX `FKD291D6053FF548F7`(`roles`) USING BTREE,
  INDEX `FKD291D605A022690F`(`admins`) USING BTREE,
  CONSTRAINT `FK_admin_role_admin` FOREIGN KEY (`admins`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_admin_role_role` FOREIGN KEY (`roles`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES (765446407850164268, 1);

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `full_name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '全称',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `tree_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树路径',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级地区',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9E19DA6CFE1E12FB`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3354 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地区' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES (1, '', '北京市', ',', 0, 0, '', NULL, 'yangcheng', '2020-09-08 16:53:45', 0);
INSERT INTO `area` VALUES (4, '北京市朝阳区', '朝阳区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (5, '北京市丰台区', '丰台区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (6, '北京市石景山区', '石景山区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (7, '北京市海淀区', '海淀区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (8, '北京市门头沟区', '门头沟区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (9, '北京市房山区', '房山区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (10, '北京市通州区', '通州区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (11, '北京市顺义区', '顺义区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (12, '北京市昌平区', '昌平区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (13, '北京市大兴区', '大兴区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (14, '北京市怀柔区', '怀柔区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (15, '北京市平谷区', '平谷区', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (16, '北京市密云县', '密云县', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (17, '北京市延庆县', '延庆县', ',1,', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (18, '', '天津市', ',', 0, 1, '', NULL, 'yangcheng', '2020-09-08 16:57:02', 0);
INSERT INTO `area` VALUES (19, '天津市和平区', '和平区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (20, '天津市河东区', '河东区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (21, '天津市河西区', '河西区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (22, '天津市南开区', '南开区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (23, '天津市河北区', '河北区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (24, '天津市红桥区', '红桥区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (25, '天津市东丽区', '东丽区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (26, '天津市西青区', '西青区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (27, '天津市津南区', '津南区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (28, '天津市北辰区', '北辰区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (29, '天津市武清区', '武清区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (30, '天津市宝坻区', '宝坻区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (31, '天津市滨海新区', '滨海新区', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (32, '天津市宁河县', '宁河县', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (33, '天津市静海县', '静海县', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (34, '天津市蓟县', '蓟县', ',18,', 18, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (35, '', '河北省', ',', 0, 2, '', NULL, 'yangcheng', '2020-09-08 16:51:01', 0);
INSERT INTO `area` VALUES (36, '河北省石家庄市', '石家庄市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (37, '河北省石家庄市长安区', '长安区', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (38, '河北省石家庄市桥东区', '桥东区', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (39, '河北省石家庄市桥西区', '桥西区', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (40, '河北省石家庄市新华区', '新华区', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (41, '河北省石家庄市井陉矿区', '井陉矿区', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (42, '河北省石家庄市裕华区', '裕华区', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (43, '河北省石家庄市井陉县', '井陉县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (44, '河北省石家庄市正定县', '正定县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (45, '河北省石家庄市栾城县', '栾城县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (46, '河北省石家庄市行唐县', '行唐县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (47, '河北省石家庄市灵寿县', '灵寿县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (48, '河北省石家庄市高邑县', '高邑县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (49, '河北省石家庄市深泽县', '深泽县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (50, '河北省石家庄市赞皇县', '赞皇县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (51, '河北省石家庄市无极县', '无极县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (52, '河北省石家庄市平山县', '平山县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (53, '河北省石家庄市元氏县', '元氏县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (54, '河北省石家庄市赵县', '赵县', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (55, '河北省石家庄市辛集市', '辛集市', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (56, '河北省石家庄市藁城市', '藁城市', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (57, '河北省石家庄市晋州市', '晋州市', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (58, '河北省石家庄市新乐市', '新乐市', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (59, '河北省石家庄市鹿泉市', '鹿泉市', ',35,36,', 36, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (60, '河北省唐山市', '唐山市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (61, '河北省唐山市路南区', '路南区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (62, '河北省唐山市路北区', '路北区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (63, '河北省唐山市古冶区', '古冶区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (64, '河北省唐山市开平区', '开平区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (65, '河北省唐山市丰南区', '丰南区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (66, '河北省唐山市丰润区', '丰润区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (67, '河北省唐山市曹妃甸区', '曹妃甸区', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (68, '河北省唐山市滦县', '滦县', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (69, '河北省唐山市滦南县', '滦南县', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (70, '河北省唐山市乐亭县', '乐亭县', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (71, '河北省唐山市迁西县', '迁西县', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (72, '河北省唐山市玉田县', '玉田县', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (73, '河北省唐山市遵化市', '遵化市', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (74, '河北省唐山市迁安市', '迁安市', ',35,60,', 60, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (75, '河北省秦皇岛市', '秦皇岛市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (76, '河北省秦皇岛市海港区', '海港区', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (77, '河北省秦皇岛市山海关区', '山海关区', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (78, '河北省秦皇岛市北戴河区', '北戴河区', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (79, '河北省秦皇岛市青龙满族自治县', '青龙满族自治县', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (80, '河北省秦皇岛市昌黎县', '昌黎县', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (81, '河北省秦皇岛市抚宁县', '抚宁县', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (82, '河北省秦皇岛市卢龙县', '卢龙县', ',35,75,', 75, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (83, '河北省邯郸市', '邯郸市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (84, '河北省邯郸市邯山区', '邯山区', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (85, '河北省邯郸市丛台区', '丛台区', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (86, '河北省邯郸市复兴区', '复兴区', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (87, '河北省邯郸市峰峰矿区', '峰峰矿区', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (88, '河北省邯郸市邯郸县', '邯郸县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (89, '河北省邯郸市临漳县', '临漳县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (90, '河北省邯郸市成安县', '成安县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (91, '河北省邯郸市大名县', '大名县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (92, '河北省邯郸市涉县', '涉县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (93, '河北省邯郸市磁县', '磁县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (94, '河北省邯郸市肥乡县', '肥乡县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (95, '河北省邯郸市永年县', '永年县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (96, '河北省邯郸市邱县', '邱县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (97, '河北省邯郸市鸡泽县', '鸡泽县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (98, '河北省邯郸市广平县', '广平县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (99, '河北省邯郸市馆陶县', '馆陶县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (100, '河北省邯郸市魏县', '魏县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (101, '河北省邯郸市曲周县', '曲周县', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (102, '河北省邯郸市武安市', '武安市', ',35,83,', 83, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (103, '河北省邢台市', '邢台市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (104, '河北省邢台市桥东区', '桥东区', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (105, '河北省邢台市桥西区', '桥西区', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (106, '河北省邢台市邢台县', '邢台县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (107, '河北省邢台市临城县', '临城县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (108, '河北省邢台市内丘县', '内丘县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (109, '河北省邢台市柏乡县', '柏乡县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (110, '河北省邢台市隆尧县', '隆尧县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (111, '河北省邢台市任县', '任县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (112, '河北省邢台市南和县', '南和县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (113, '河北省邢台市宁晋县', '宁晋县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (114, '河北省邢台市巨鹿县', '巨鹿县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (115, '河北省邢台市新河县', '新河县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (116, '河北省邢台市广宗县', '广宗县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (117, '河北省邢台市平乡县', '平乡县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (118, '河北省邢台市威县', '威县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (119, '河北省邢台市清河县', '清河县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (120, '河北省邢台市临西县', '临西县', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (121, '河北省邢台市南宫市', '南宫市', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (122, '河北省邢台市沙河市', '沙河市', ',35,103,', 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (123, '河北省保定市', '保定市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (124, '河北省保定市新市区', '新市区', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (125, '河北省保定市北市区', '北市区', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (126, '河北省保定市南市区', '南市区', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (127, '河北省保定市满城县', '满城县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (128, '河北省保定市清苑县', '清苑县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (129, '河北省保定市涞水县', '涞水县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (130, '河北省保定市阜平县', '阜平县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (131, '河北省保定市徐水县', '徐水县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (132, '河北省保定市定兴县', '定兴县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (133, '河北省保定市唐县', '唐县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (134, '河北省保定市高阳县', '高阳县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (135, '河北省保定市容城县', '容城县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (136, '河北省保定市涞源县', '涞源县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (137, '河北省保定市望都县', '望都县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (138, '河北省保定市安新县', '安新县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (139, '河北省保定市易县', '易县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (140, '河北省保定市曲阳县', '曲阳县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (141, '河北省保定市蠡县', '蠡县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (142, '河北省保定市顺平县', '顺平县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (143, '河北省保定市博野县', '博野县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (144, '河北省保定市雄县', '雄县', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (145, '河北省保定市涿州市', '涿州市', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (146, '河北省保定市定州市', '定州市', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (147, '河北省保定市安国市', '安国市', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (148, '河北省保定市高碑店市', '高碑店市', ',35,123,', 123, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (149, '河北省张家口市', '张家口市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (150, '河北省张家口市桥东区', '桥东区', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (151, '河北省张家口市桥西区', '桥西区', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (152, '河北省张家口市宣化区', '宣化区', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (153, '河北省张家口市下花园区', '下花园区', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (154, '河北省张家口市宣化县', '宣化县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (155, '河北省张家口市张北县', '张北县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (156, '河北省张家口市康保县', '康保县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (157, '河北省张家口市沽源县', '沽源县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (158, '河北省张家口市尚义县', '尚义县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (159, '河北省张家口市蔚县', '蔚县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (160, '河北省张家口市阳原县', '阳原县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (161, '河北省张家口市怀安县', '怀安县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (162, '河北省张家口市万全县', '万全县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (163, '河北省张家口市怀来县', '怀来县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (164, '河北省张家口市涿鹿县', '涿鹿县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (165, '河北省张家口市赤城县', '赤城县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (166, '河北省张家口市崇礼县', '崇礼县', ',35,149,', 149, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (167, '河北省承德市', '承德市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (168, '河北省承德市双桥区', '双桥区', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (169, '河北省承德市双滦区', '双滦区', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (170, '河北省承德市鹰手营子矿区', '鹰手营子矿区', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (171, '河北省承德市承德县', '承德县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (172, '河北省承德市兴隆县', '兴隆县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (173, '河北省承德市平泉县', '平泉县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (174, '河北省承德市滦平县', '滦平县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (175, '河北省承德市隆化县', '隆化县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (176, '河北省承德市丰宁满族自治县', '丰宁满族自治县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (177, '河北省承德市宽城满族自治县', '宽城满族自治县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (178, '河北省承德市围场满族蒙古族自治县', '围场满族蒙古族自治县', ',35,167,', 167, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (179, '河北省沧州市', '沧州市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (180, '河北省沧州市新华区', '新华区', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (181, '河北省沧州市运河区', '运河区', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (182, '河北省沧州市沧县', '沧县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (183, '河北省沧州市青县', '青县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (184, '河北省沧州市东光县', '东光县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (185, '河北省沧州市海兴县', '海兴县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (186, '河北省沧州市盐山县', '盐山县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (187, '河北省沧州市肃宁县', '肃宁县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (188, '河北省沧州市南皮县', '南皮县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (189, '河北省沧州市吴桥县', '吴桥县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (190, '河北省沧州市献县', '献县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (191, '河北省沧州市孟村回族自治县', '孟村回族自治县', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (192, '河北省沧州市泊头市', '泊头市', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (193, '河北省沧州市任丘市', '任丘市', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (194, '河北省沧州市黄骅市', '黄骅市', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (195, '河北省沧州市河间市', '河间市', ',35,179,', 179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (196, '河北省廊坊市', '廊坊市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (197, '河北省廊坊市安次区', '安次区', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (198, '河北省廊坊市广阳区', '广阳区', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (199, '河北省廊坊市固安县', '固安县', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (200, '河北省廊坊市永清县', '永清县', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (201, '河北省廊坊市香河县', '香河县', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (202, '河北省廊坊市大城县', '大城县', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (203, '河北省廊坊市文安县', '文安县', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (204, '河北省廊坊市大厂回族自治县', '大厂回族自治县', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (205, '河北省廊坊市霸州市', '霸州市', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (206, '河北省廊坊市三河市', '三河市', ',35,196,', 196, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (207, '河北省衡水市', '衡水市', ',35,', 35, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (208, '河北省衡水市桃城区', '桃城区', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (209, '河北省衡水市枣强县', '枣强县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (210, '河北省衡水市武邑县', '武邑县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (211, '河北省衡水市武强县', '武强县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (212, '河北省衡水市饶阳县', '饶阳县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (213, '河北省衡水市安平县', '安平县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (214, '河北省衡水市故城县', '故城县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (215, '河北省衡水市景县', '景县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (216, '河北省衡水市阜城县', '阜城县', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (217, '河北省衡水市冀州市', '冀州市', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (218, '河北省衡水市深州市', '深州市', ',35,207,', 207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (219, '山西省', '山西省', ',', NULL, 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (220, '山西省太原市', '太原市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (221, '山西省太原市小店区', '小店区', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (222, '山西省太原市迎泽区', '迎泽区', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (223, '山西省太原市杏花岭区', '杏花岭区', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (224, '山西省太原市尖草坪区', '尖草坪区', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (225, '山西省太原市万柏林区', '万柏林区', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (226, '山西省太原市晋源区', '晋源区', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (227, '山西省太原市清徐县', '清徐县', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (228, '山西省太原市阳曲县', '阳曲县', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (229, '山西省太原市娄烦县', '娄烦县', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (230, '山西省太原市古交市', '古交市', ',219,220,', 220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (231, '山西省大同市', '大同市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (232, '山西省大同市城区', '城区', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (233, '山西省大同市矿区', '矿区', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (234, '山西省大同市南郊区', '南郊区', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (235, '山西省大同市新荣区', '新荣区', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (236, '山西省大同市阳高县', '阳高县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (237, '山西省大同市天镇县', '天镇县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (238, '山西省大同市广灵县', '广灵县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (239, '山西省大同市灵丘县', '灵丘县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (240, '山西省大同市浑源县', '浑源县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (241, '山西省大同市左云县', '左云县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (242, '山西省大同市大同县', '大同县', ',219,231,', 231, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (243, '山西省阳泉市', '阳泉市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (244, '山西省阳泉市城区', '城区', ',219,243,', 243, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (245, '山西省阳泉市矿区', '矿区', ',219,243,', 243, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (246, '山西省阳泉市郊区', '郊区', ',219,243,', 243, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (247, '山西省阳泉市平定县', '平定县', ',219,243,', 243, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (248, '山西省阳泉市盂县', '盂县', ',219,243,', 243, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (249, '山西省长治市', '长治市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (250, '山西省长治市城区', '城区', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (251, '山西省长治市郊区', '郊区', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (252, '山西省长治市长治县', '长治县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (253, '山西省长治市襄垣县', '襄垣县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (254, '山西省长治市屯留县', '屯留县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (255, '山西省长治市平顺县', '平顺县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (256, '山西省长治市黎城县', '黎城县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (257, '山西省长治市壶关县', '壶关县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (258, '山西省长治市长子县', '长子县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (259, '山西省长治市武乡县', '武乡县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (260, '山西省长治市沁县', '沁县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (261, '山西省长治市沁源县', '沁源县', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (262, '山西省长治市潞城市', '潞城市', ',219,249,', 249, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (263, '山西省晋城市', '晋城市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (264, '山西省晋城市晋城市市辖区', '晋城市市辖区', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (265, '山西省晋城市城区', '城区', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (266, '山西省晋城市沁水县', '沁水县', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (267, '山西省晋城市阳城县', '阳城县', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (268, '山西省晋城市陵川县', '陵川县', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (269, '山西省晋城市泽州县', '泽州县', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (270, '山西省晋城市高平市', '高平市', ',219,263,', 263, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (271, '山西省朔州市', '朔州市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (272, '山西省朔州市朔城区', '朔城区', ',219,271,', 271, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (273, '山西省朔州市平鲁区', '平鲁区', ',219,271,', 271, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (274, '山西省朔州市山阴县', '山阴县', ',219,271,', 271, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (275, '山西省朔州市应县', '应县', ',219,271,', 271, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (276, '山西省朔州市右玉县', '右玉县', ',219,271,', 271, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (277, '山西省朔州市怀仁县', '怀仁县', ',219,271,', 271, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (278, '山西省晋中市', '晋中市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (279, '山西省晋中市榆次区', '榆次区', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (280, '山西省晋中市榆社县', '榆社县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (281, '山西省晋中市左权县', '左权县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (282, '山西省晋中市和顺县', '和顺县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (283, '山西省晋中市昔阳县', '昔阳县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (284, '山西省晋中市寿阳县', '寿阳县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (285, '山西省晋中市太谷县', '太谷县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (286, '山西省晋中市祁县', '祁县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (287, '山西省晋中市平遥县', '平遥县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (288, '山西省晋中市灵石县', '灵石县', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (289, '山西省晋中市介休市', '介休市', ',219,278,', 278, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (290, '山西省运城市', '运城市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (291, '山西省运城市盐湖区', '盐湖区', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (292, '山西省运城市临猗县', '临猗县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (293, '山西省运城市万荣县', '万荣县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (294, '山西省运城市闻喜县', '闻喜县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (295, '山西省运城市稷山县', '稷山县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (296, '山西省运城市新绛县', '新绛县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (297, '山西省运城市绛县', '绛县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (298, '山西省运城市垣曲县', '垣曲县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (299, '山西省运城市夏县', '夏县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (300, '山西省运城市平陆县', '平陆县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (301, '山西省运城市芮城县', '芮城县', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (302, '山西省运城市永济市', '永济市', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (303, '山西省运城市河津市', '河津市', ',219,290,', 290, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (304, '山西省忻州市', '忻州市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (305, '山西省忻州市忻府区', '忻府区', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (306, '山西省忻州市定襄县', '定襄县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (307, '山西省忻州市五台县', '五台县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (308, '山西省忻州市代县', '代县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (309, '山西省忻州市繁峙县', '繁峙县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (310, '山西省忻州市宁武县', '宁武县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (311, '山西省忻州市静乐县', '静乐县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (312, '山西省忻州市神池县', '神池县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (313, '山西省忻州市五寨县', '五寨县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (314, '山西省忻州市岢岚县', '岢岚县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (315, '山西省忻州市河曲县', '河曲县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (316, '山西省忻州市保德县', '保德县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (317, '山西省忻州市偏关县', '偏关县', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (318, '山西省忻州市原平市', '原平市', ',219,304,', 304, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (319, '山西省临汾市', '临汾市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (320, '山西省临汾市尧都区', '尧都区', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (321, '山西省临汾市曲沃县', '曲沃县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (322, '山西省临汾市翼城县', '翼城县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (323, '山西省临汾市襄汾县', '襄汾县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (324, '山西省临汾市洪洞县', '洪洞县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (325, '山西省临汾市古县', '古县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (326, '山西省临汾市安泽县', '安泽县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (327, '山西省临汾市浮山县', '浮山县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (328, '山西省临汾市吉县', '吉县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (329, '山西省临汾市乡宁县', '乡宁县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (330, '山西省临汾市大宁县', '大宁县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (331, '山西省临汾市隰县', '隰县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (332, '山西省临汾市永和县', '永和县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (333, '山西省临汾市蒲县', '蒲县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (334, '山西省临汾市汾西县', '汾西县', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (335, '山西省临汾市侯马市', '侯马市', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (336, '山西省临汾市霍州市', '霍州市', ',219,319,', 319, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (337, '山西省吕梁市', '吕梁市', ',219,', 219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (338, '山西省吕梁市离石区', '离石区', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (339, '山西省吕梁市文水县', '文水县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (340, '山西省吕梁市交城县', '交城县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (341, '山西省吕梁市兴县', '兴县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (342, '山西省吕梁市临县', '临县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (343, '山西省吕梁市柳林县', '柳林县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (344, '山西省吕梁市石楼县', '石楼县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (345, '山西省吕梁市岚县', '岚县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (346, '山西省吕梁市方山县', '方山县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (347, '山西省吕梁市中阳县', '中阳县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (348, '山西省吕梁市交口县', '交口县', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (349, '山西省吕梁市孝义市', '孝义市', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (350, '山西省吕梁市汾阳市', '汾阳市', ',219,337,', 337, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (351, '内蒙古自治区', '内蒙古自治区', ',', NULL, 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (352, '内蒙古自治区呼和浩特市', '呼和浩特市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (353, '内蒙古自治区呼和浩特市新城区', '新城区', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (354, '内蒙古自治区呼和浩特市回民区', '回民区', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (355, '内蒙古自治区呼和浩特市玉泉区', '玉泉区', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (356, '内蒙古自治区呼和浩特市赛罕区', '赛罕区', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (357, '内蒙古自治区呼和浩特市土默特左旗', '土默特左旗', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (358, '内蒙古自治区呼和浩特市托克托县', '托克托县', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (359, '内蒙古自治区呼和浩特市和林格尔县', '和林格尔县', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (360, '内蒙古自治区呼和浩特市清水河县', '清水河县', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (361, '内蒙古自治区呼和浩特市武川县', '武川县', ',351,352,', 352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (362, '内蒙古自治区包头市', '包头市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (363, '内蒙古自治区包头市东河区', '东河区', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (364, '内蒙古自治区包头市昆都仑区', '昆都仑区', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (365, '内蒙古自治区包头市青山区', '青山区', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (366, '内蒙古自治区包头市石拐区', '石拐区', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (367, '内蒙古自治区包头市白云鄂博矿区', '白云鄂博矿区', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (368, '内蒙古自治区包头市九原区', '九原区', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (369, '内蒙古自治区包头市土默特右旗', '土默特右旗', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (370, '内蒙古自治区包头市固阳县', '固阳县', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (371, '内蒙古自治区包头市达尔罕茂明安联合旗', '达尔罕茂明安联合旗', ',351,362,', 362, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (372, '内蒙古自治区乌海市', '乌海市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (373, '内蒙古自治区乌海市海勃湾区', '海勃湾区', ',351,372,', 372, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (374, '内蒙古自治区乌海市海南区', '海南区', ',351,372,', 372, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (375, '内蒙古自治区乌海市乌达区', '乌达区', ',351,372,', 372, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (376, '内蒙古自治区赤峰市', '赤峰市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (377, '内蒙古自治区赤峰市红山区', '红山区', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (378, '内蒙古自治区赤峰市元宝山区', '元宝山区', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (379, '内蒙古自治区赤峰市松山区', '松山区', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (380, '内蒙古自治区赤峰市阿鲁科尔沁旗', '阿鲁科尔沁旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (381, '内蒙古自治区赤峰市巴林左旗', '巴林左旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (382, '内蒙古自治区赤峰市巴林右旗', '巴林右旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (383, '内蒙古自治区赤峰市林西县', '林西县', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (384, '内蒙古自治区赤峰市克什克腾旗', '克什克腾旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (385, '内蒙古自治区赤峰市翁牛特旗', '翁牛特旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (386, '内蒙古自治区赤峰市喀喇沁旗', '喀喇沁旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (387, '内蒙古自治区赤峰市宁城县', '宁城县', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (388, '内蒙古自治区赤峰市敖汉旗', '敖汉旗', ',351,376,', 376, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (389, '内蒙古自治区通辽市', '通辽市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (390, '内蒙古自治区通辽市科尔沁区', '科尔沁区', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (391, '内蒙古自治区通辽市科尔沁左翼中旗', '科尔沁左翼中旗', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (392, '内蒙古自治区通辽市科尔沁左翼后旗', '科尔沁左翼后旗', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (393, '内蒙古自治区通辽市开鲁县', '开鲁县', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (394, '内蒙古自治区通辽市库伦旗', '库伦旗', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (395, '内蒙古自治区通辽市奈曼旗', '奈曼旗', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (396, '内蒙古自治区通辽市扎鲁特旗', '扎鲁特旗', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (397, '内蒙古自治区通辽市霍林郭勒市', '霍林郭勒市', ',351,389,', 389, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (398, '内蒙古自治区鄂尔多斯市', '鄂尔多斯市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (399, '内蒙古自治区鄂尔多斯市东胜区', '东胜区', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (400, '内蒙古自治区鄂尔多斯市达拉特旗', '达拉特旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (401, '内蒙古自治区鄂尔多斯市准格尔旗', '准格尔旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (402, '内蒙古自治区鄂尔多斯市鄂托克前旗', '鄂托克前旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (403, '内蒙古自治区鄂尔多斯市鄂托克旗', '鄂托克旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (404, '内蒙古自治区鄂尔多斯市杭锦旗', '杭锦旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (405, '内蒙古自治区鄂尔多斯市乌审旗', '乌审旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (406, '内蒙古自治区鄂尔多斯市伊金霍洛旗', '伊金霍洛旗', ',351,398,', 398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (407, '内蒙古自治区呼伦贝尔市', '呼伦贝尔市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (408, '内蒙古自治区呼伦贝尔市海拉尔区', '海拉尔区', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (409, '内蒙古自治区呼伦贝尔市阿荣旗', '阿荣旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (410, '内蒙古自治区呼伦贝尔市莫力达瓦达斡尔族自治旗', '莫力达瓦达斡尔族自治旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (411, '内蒙古自治区呼伦贝尔市鄂伦春自治旗', '鄂伦春自治旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (412, '内蒙古自治区呼伦贝尔市鄂温克族自治旗', '鄂温克族自治旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (413, '内蒙古自治区呼伦贝尔市陈巴尔虎旗', '陈巴尔虎旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (414, '内蒙古自治区呼伦贝尔市新巴尔虎左旗', '新巴尔虎左旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (415, '内蒙古自治区呼伦贝尔市新巴尔虎右旗', '新巴尔虎右旗', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (416, '内蒙古自治区呼伦贝尔市满洲里市', '满洲里市', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (417, '内蒙古自治区呼伦贝尔市牙克石市', '牙克石市', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (418, '内蒙古自治区呼伦贝尔市扎兰屯市', '扎兰屯市', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (419, '内蒙古自治区呼伦贝尔市额尔古纳市', '额尔古纳市', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (420, '内蒙古自治区呼伦贝尔市根河市', '根河市', ',351,407,', 407, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (421, '内蒙古自治区巴彦淖尔市', '巴彦淖尔市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (422, '内蒙古自治区巴彦淖尔市临河区', '临河区', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (423, '内蒙古自治区巴彦淖尔市五原县', '五原县', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (424, '内蒙古自治区巴彦淖尔市磴口县', '磴口县', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (425, '内蒙古自治区巴彦淖尔市乌拉特前旗', '乌拉特前旗', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (426, '内蒙古自治区巴彦淖尔市乌拉特中旗', '乌拉特中旗', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (427, '内蒙古自治区巴彦淖尔市乌拉特后旗', '乌拉特后旗', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (428, '内蒙古自治区巴彦淖尔市杭锦后旗', '杭锦后旗', ',351,421,', 421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (429, '内蒙古自治区乌兰察布市', '乌兰察布市', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (430, '内蒙古自治区乌兰察布市集宁区', '集宁区', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (431, '内蒙古自治区乌兰察布市卓资县', '卓资县', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (432, '内蒙古自治区乌兰察布市化德县', '化德县', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (433, '内蒙古自治区乌兰察布市商都县', '商都县', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (434, '内蒙古自治区乌兰察布市兴和县', '兴和县', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (435, '内蒙古自治区乌兰察布市凉城县', '凉城县', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (436, '内蒙古自治区乌兰察布市察哈尔右翼前旗', '察哈尔右翼前旗', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (437, '内蒙古自治区乌兰察布市察哈尔右翼中旗', '察哈尔右翼中旗', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (438, '内蒙古自治区乌兰察布市察哈尔右翼后旗', '察哈尔右翼后旗', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (439, '内蒙古自治区乌兰察布市四子王旗', '四子王旗', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (440, '内蒙古自治区乌兰察布市丰镇市', '丰镇市', ',351,429,', 429, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (441, '内蒙古自治区兴安盟', '兴安盟', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (442, '内蒙古自治区兴安盟乌兰浩特市', '乌兰浩特市', ',351,441,', 441, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (443, '内蒙古自治区兴安盟阿尔山市', '阿尔山市', ',351,441,', 441, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (444, '内蒙古自治区兴安盟科尔沁右翼前旗', '科尔沁右翼前旗', ',351,441,', 441, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (445, '内蒙古自治区兴安盟科尔沁右翼中旗', '科尔沁右翼中旗', ',351,441,', 441, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (446, '内蒙古自治区兴安盟扎赉特旗', '扎赉特旗', ',351,441,', 441, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (447, '内蒙古自治区兴安盟突泉县', '突泉县', ',351,441,', 441, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (448, '内蒙古自治区锡林郭勒盟', '锡林郭勒盟', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (449, '内蒙古自治区锡林郭勒盟二连浩特市', '二连浩特市', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (450, '内蒙古自治区锡林郭勒盟锡林浩特市', '锡林浩特市', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (451, '内蒙古自治区锡林郭勒盟阿巴嘎旗', '阿巴嘎旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (452, '内蒙古自治区锡林郭勒盟苏尼特左旗', '苏尼特左旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (453, '内蒙古自治区锡林郭勒盟苏尼特右旗', '苏尼特右旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (454, '内蒙古自治区锡林郭勒盟东乌珠穆沁旗', '东乌珠穆沁旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (455, '内蒙古自治区锡林郭勒盟西乌珠穆沁旗', '西乌珠穆沁旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (456, '内蒙古自治区锡林郭勒盟太仆寺旗', '太仆寺旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (457, '内蒙古自治区锡林郭勒盟镶黄旗', '镶黄旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (458, '内蒙古自治区锡林郭勒盟正镶白旗', '正镶白旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (459, '内蒙古自治区锡林郭勒盟正蓝旗', '正蓝旗', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (460, '内蒙古自治区锡林郭勒盟多伦县', '多伦县', ',351,448,', 448, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (461, '内蒙古自治区阿拉善盟', '阿拉善盟', ',351,', 351, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (462, '内蒙古自治区阿拉善盟阿拉善左旗', '阿拉善左旗', ',351,461,', 461, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (463, '内蒙古自治区阿拉善盟阿拉善右旗', '阿拉善右旗', ',351,461,', 461, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (464, '内蒙古自治区阿拉善盟额济纳旗', '额济纳旗', ',351,461,', 461, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (465, '辽宁省', '辽宁省', ',', NULL, 5, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (466, '辽宁省沈阳市', '沈阳市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (467, '辽宁省沈阳市和平区', '和平区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (468, '辽宁省沈阳市沈河区', '沈河区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (469, '辽宁省沈阳市大东区', '大东区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (470, '辽宁省沈阳市皇姑区', '皇姑区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (471, '辽宁省沈阳市铁西区', '铁西区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (472, '辽宁省沈阳市苏家屯区', '苏家屯区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (473, '辽宁省沈阳市东陵区', '东陵区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (474, '辽宁省沈阳市沈北新区', '沈北新区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (475, '辽宁省沈阳市于洪区', '于洪区', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (476, '辽宁省沈阳市辽中县', '辽中县', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (477, '辽宁省沈阳市康平县', '康平县', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (478, '辽宁省沈阳市法库县', '法库县', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (479, '辽宁省沈阳市新民市', '新民市', ',465,466,', 466, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (480, '辽宁省大连市', '大连市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (481, '辽宁省大连市中山区', '中山区', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (482, '辽宁省大连市西岗区', '西岗区', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (483, '辽宁省大连市沙河口区', '沙河口区', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (484, '辽宁省大连市甘井子区', '甘井子区', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (485, '辽宁省大连市旅顺口区', '旅顺口区', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (486, '辽宁省大连市金州区', '金州区', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (487, '辽宁省大连市长海县', '长海县', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (488, '辽宁省大连市瓦房店市', '瓦房店市', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (489, '辽宁省大连市普兰店市', '普兰店市', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (490, '辽宁省大连市庄河市', '庄河市', ',465,480,', 480, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (491, '辽宁省鞍山市', '鞍山市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (492, '辽宁省鞍山市铁东区', '铁东区', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (493, '辽宁省鞍山市铁西区', '铁西区', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (494, '辽宁省鞍山市立山区', '立山区', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (495, '辽宁省鞍山市千山区', '千山区', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (496, '辽宁省鞍山市台安县', '台安县', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (497, '辽宁省鞍山市岫岩满族自治县', '岫岩满族自治县', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (498, '辽宁省鞍山市海城市', '海城市', ',465,491,', 491, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (499, '辽宁省抚顺市', '抚顺市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (500, '辽宁省抚顺市新抚区', '新抚区', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (501, '辽宁省抚顺市东洲区', '东洲区', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (502, '辽宁省抚顺市望花区', '望花区', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (503, '辽宁省抚顺市顺城区', '顺城区', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (504, '辽宁省抚顺市抚顺县', '抚顺县', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (505, '辽宁省抚顺市新宾满族自治县', '新宾满族自治县', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (506, '辽宁省抚顺市清原满族自治县', '清原满族自治县', ',465,499,', 499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (507, '辽宁省本溪市', '本溪市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (508, '辽宁省本溪市平山区', '平山区', ',465,507,', 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (509, '辽宁省本溪市溪湖区', '溪湖区', ',465,507,', 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (510, '辽宁省本溪市明山区', '明山区', ',465,507,', 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (511, '辽宁省本溪市南芬区', '南芬区', ',465,507,', 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (512, '辽宁省本溪市本溪满族自治县', '本溪满族自治县', ',465,507,', 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (513, '辽宁省本溪市桓仁满族自治县', '桓仁满族自治县', ',465,507,', 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (514, '辽宁省丹东市', '丹东市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (515, '辽宁省丹东市元宝区', '元宝区', ',465,514,', 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (516, '辽宁省丹东市振兴区', '振兴区', ',465,514,', 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (517, '辽宁省丹东市振安区', '振安区', ',465,514,', 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (518, '辽宁省丹东市宽甸满族自治县', '宽甸满族自治县', ',465,514,', 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (519, '辽宁省丹东市东港市', '东港市', ',465,514,', 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (520, '辽宁省丹东市凤城市', '凤城市', ',465,514,', 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (521, '辽宁省锦州市', '锦州市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (522, '辽宁省锦州市古塔区', '古塔区', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (523, '辽宁省锦州市凌河区', '凌河区', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (524, '辽宁省锦州市太和区', '太和区', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (525, '辽宁省锦州市黑山县', '黑山县', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (526, '辽宁省锦州市义县', '义县', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (527, '辽宁省锦州市凌海市', '凌海市', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (528, '辽宁省锦州市北镇市', '北镇市', ',465,521,', 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (529, '辽宁省营口市', '营口市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (530, '辽宁省营口市站前区', '站前区', ',465,529,', 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (531, '辽宁省营口市西市区', '西市区', ',465,529,', 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (532, '辽宁省营口市鲅鱼圈区', '鲅鱼圈区', ',465,529,', 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (533, '辽宁省营口市老边区', '老边区', ',465,529,', 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (534, '辽宁省营口市盖州市', '盖州市', ',465,529,', 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (535, '辽宁省营口市大石桥市', '大石桥市', ',465,529,', 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (536, '辽宁省阜新市', '阜新市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (537, '辽宁省阜新市海州区', '海州区', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (538, '辽宁省阜新市新邱区', '新邱区', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (539, '辽宁省阜新市太平区', '太平区', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (540, '辽宁省阜新市清河门区', '清河门区', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (541, '辽宁省阜新市细河区', '细河区', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (542, '辽宁省阜新市阜新蒙古族自治县', '阜新蒙古族自治县', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (543, '辽宁省阜新市彰武县', '彰武县', ',465,536,', 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (544, '辽宁省辽阳市', '辽阳市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (545, '辽宁省辽阳市白塔区', '白塔区', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (546, '辽宁省辽阳市文圣区', '文圣区', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (547, '辽宁省辽阳市宏伟区', '宏伟区', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (548, '辽宁省辽阳市弓长岭区', '弓长岭区', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (549, '辽宁省辽阳市太子河区', '太子河区', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (550, '辽宁省辽阳市辽阳县', '辽阳县', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (551, '辽宁省辽阳市灯塔市', '灯塔市', ',465,544,', 544, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (552, '辽宁省盘锦市', '盘锦市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (553, '辽宁省盘锦市双台子区', '双台子区', ',465,552,', 552, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (554, '辽宁省盘锦市兴隆台区', '兴隆台区', ',465,552,', 552, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (555, '辽宁省盘锦市大洼县', '大洼县', ',465,552,', 552, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (556, '辽宁省盘锦市盘山县', '盘山县', ',465,552,', 552, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (557, '辽宁省铁岭市', '铁岭市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (558, '辽宁省铁岭市银州区', '银州区', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (559, '辽宁省铁岭市清河区', '清河区', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (560, '辽宁省铁岭市铁岭县', '铁岭县', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (561, '辽宁省铁岭市西丰县', '西丰县', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (562, '辽宁省铁岭市昌图县', '昌图县', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (563, '辽宁省铁岭市调兵山市', '调兵山市', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (564, '辽宁省铁岭市开原市', '开原市', ',465,557,', 557, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (565, '辽宁省朝阳市', '朝阳市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (566, '辽宁省朝阳市双塔区', '双塔区', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (567, '辽宁省朝阳市龙城区', '龙城区', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (568, '辽宁省朝阳市朝阳县', '朝阳县', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (569, '辽宁省朝阳市建平县', '建平县', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (570, '辽宁省朝阳市喀喇沁左翼蒙古族自治县', '喀喇沁左翼蒙古族自治县', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (571, '辽宁省朝阳市北票市', '北票市', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (572, '辽宁省朝阳市凌源市', '凌源市', ',465,565,', 565, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (573, '辽宁省葫芦岛市', '葫芦岛市', ',465,', 465, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (574, '辽宁省葫芦岛市连山区', '连山区', ',465,573,', 573, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (575, '辽宁省葫芦岛市龙港区', '龙港区', ',465,573,', 573, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (576, '辽宁省葫芦岛市南票区', '南票区', ',465,573,', 573, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (577, '辽宁省葫芦岛市绥中县', '绥中县', ',465,573,', 573, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (578, '辽宁省葫芦岛市建昌县', '建昌县', ',465,573,', 573, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (579, '辽宁省葫芦岛市兴城市', '兴城市', ',465,573,', 573, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (580, '吉林省', '吉林省', ',', NULL, 6, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (581, '吉林省长春市', '长春市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (582, '吉林省长春市南关区', '南关区', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (583, '吉林省长春市宽城区', '宽城区', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (584, '吉林省长春市朝阳区', '朝阳区', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (585, '吉林省长春市二道区', '二道区', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (586, '吉林省长春市绿园区', '绿园区', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (587, '吉林省长春市双阳区', '双阳区', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (588, '吉林省长春市农安县', '农安县', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (589, '吉林省长春市九台市', '九台市', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (590, '吉林省长春市榆树市', '榆树市', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (591, '吉林省长春市德惠市', '德惠市', ',580,581,', 581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (592, '吉林省吉林市', '吉林市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (593, '吉林省吉林市昌邑区', '昌邑区', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (594, '吉林省吉林市龙潭区', '龙潭区', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (595, '吉林省吉林市船营区', '船营区', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (596, '吉林省吉林市丰满区', '丰满区', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (597, '吉林省吉林市永吉县', '永吉县', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (598, '吉林省吉林市蛟河市', '蛟河市', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (599, '吉林省吉林市桦甸市', '桦甸市', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (600, '吉林省吉林市舒兰市', '舒兰市', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (601, '吉林省吉林市磐石市', '磐石市', ',580,592,', 592, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (602, '吉林省四平市', '四平市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (603, '吉林省四平市铁西区', '铁西区', ',580,602,', 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (604, '吉林省四平市铁东区', '铁东区', ',580,602,', 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (605, '吉林省四平市梨树县', '梨树县', ',580,602,', 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (606, '吉林省四平市伊通满族自治县', '伊通满族自治县', ',580,602,', 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (607, '吉林省四平市公主岭市', '公主岭市', ',580,602,', 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (608, '吉林省四平市双辽市', '双辽市', ',580,602,', 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (609, '吉林省辽源市', '辽源市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (610, '吉林省辽源市龙山区', '龙山区', ',580,609,', 609, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (611, '吉林省辽源市西安区', '西安区', ',580,609,', 609, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (612, '吉林省辽源市东丰县', '东丰县', ',580,609,', 609, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (613, '吉林省辽源市东辽县', '东辽县', ',580,609,', 609, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (614, '吉林省通化市', '通化市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (615, '吉林省通化市东昌区', '东昌区', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (616, '吉林省通化市二道江区', '二道江区', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (617, '吉林省通化市通化县', '通化县', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (618, '吉林省通化市辉南县', '辉南县', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (619, '吉林省通化市柳河县', '柳河县', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (620, '吉林省通化市梅河口市', '梅河口市', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (621, '吉林省通化市集安市', '集安市', ',580,614,', 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (622, '吉林省白山市', '白山市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (623, '吉林省白山市浑江区', '浑江区', ',580,622,', 622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (624, '吉林省白山市江源区', '江源区', ',580,622,', 622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (625, '吉林省白山市抚松县', '抚松县', ',580,622,', 622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (626, '吉林省白山市靖宇县', '靖宇县', ',580,622,', 622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (627, '吉林省白山市长白朝鲜族自治县', '长白朝鲜族自治县', ',580,622,', 622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (628, '吉林省白山市临江市', '临江市', ',580,622,', 622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (629, '吉林省松原市', '松原市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (630, '吉林省松原市宁江区', '宁江区', ',580,629,', 629, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (631, '吉林省松原市前郭尔罗斯蒙古族自治县', '前郭尔罗斯蒙古族自治县', ',580,629,', 629, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (632, '吉林省松原市长岭县', '长岭县', ',580,629,', 629, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (633, '吉林省松原市乾安县', '乾安县', ',580,629,', 629, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (634, '吉林省松原市扶余县', '扶余县', ',580,629,', 629, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (635, '吉林省白城市', '白城市', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (636, '吉林省白城市洮北区', '洮北区', ',580,635,', 635, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (637, '吉林省白城市镇赉县', '镇赉县', ',580,635,', 635, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (638, '吉林省白城市通榆县', '通榆县', ',580,635,', 635, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (639, '吉林省白城市洮南市', '洮南市', ',580,635,', 635, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (640, '吉林省白城市大安市', '大安市', ',580,635,', 635, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (641, '吉林省延边朝鲜族自治州', '延边朝鲜族自治州', ',580,', 580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (642, '吉林省延边朝鲜族自治州延吉市', '延吉市', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (643, '吉林省延边朝鲜族自治州图们市', '图们市', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (644, '吉林省延边朝鲜族自治州敦化市', '敦化市', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (645, '吉林省延边朝鲜族自治州珲春市', '珲春市', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (646, '吉林省延边朝鲜族自治州龙井市', '龙井市', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (647, '吉林省延边朝鲜族自治州和龙市', '和龙市', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (648, '吉林省延边朝鲜族自治州汪清县', '汪清县', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (649, '吉林省延边朝鲜族自治州安图县', '安图县', ',580,641,', 641, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (650, '黑龙江省', '黑龙江省', ',', NULL, 7, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (651, '黑龙江省哈尔滨市', '哈尔滨市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (652, '黑龙江省哈尔滨市道里区', '道里区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (653, '黑龙江省哈尔滨市南岗区', '南岗区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (654, '黑龙江省哈尔滨市道外区', '道外区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (655, '黑龙江省哈尔滨市平房区', '平房区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (656, '黑龙江省哈尔滨市松北区', '松北区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (657, '黑龙江省哈尔滨市香坊区', '香坊区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (658, '黑龙江省哈尔滨市呼兰区', '呼兰区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (659, '黑龙江省哈尔滨市阿城区', '阿城区', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (660, '黑龙江省哈尔滨市依兰县', '依兰县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (661, '黑龙江省哈尔滨市方正县', '方正县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (662, '黑龙江省哈尔滨市宾县', '宾县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (663, '黑龙江省哈尔滨市巴彦县', '巴彦县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (664, '黑龙江省哈尔滨市木兰县', '木兰县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (665, '黑龙江省哈尔滨市通河县', '通河县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (666, '黑龙江省哈尔滨市延寿县', '延寿县', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (667, '黑龙江省哈尔滨市双城市', '双城市', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (668, '黑龙江省哈尔滨市尚志市', '尚志市', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (669, '黑龙江省哈尔滨市五常市', '五常市', ',650,651,', 651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (670, '黑龙江省齐齐哈尔市', '齐齐哈尔市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (671, '黑龙江省齐齐哈尔市龙沙区', '龙沙区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (672, '黑龙江省齐齐哈尔市建华区', '建华区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (673, '黑龙江省齐齐哈尔市铁锋区', '铁锋区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (674, '黑龙江省齐齐哈尔市昂昂溪区', '昂昂溪区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (675, '黑龙江省齐齐哈尔市富拉尔基区', '富拉尔基区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (676, '黑龙江省齐齐哈尔市碾子山区', '碾子山区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (677, '黑龙江省齐齐哈尔市梅里斯达斡尔族区', '梅里斯达斡尔族区', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (678, '黑龙江省齐齐哈尔市龙江县', '龙江县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (679, '黑龙江省齐齐哈尔市依安县', '依安县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (680, '黑龙江省齐齐哈尔市泰来县', '泰来县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (681, '黑龙江省齐齐哈尔市甘南县', '甘南县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (682, '黑龙江省齐齐哈尔市富裕县', '富裕县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (683, '黑龙江省齐齐哈尔市克山县', '克山县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (684, '黑龙江省齐齐哈尔市克东县', '克东县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (685, '黑龙江省齐齐哈尔市拜泉县', '拜泉县', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (686, '黑龙江省齐齐哈尔市讷河市', '讷河市', ',650,670,', 670, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (687, '黑龙江省鸡西市', '鸡西市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (688, '黑龙江省鸡西市鸡冠区', '鸡冠区', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (689, '黑龙江省鸡西市恒山区', '恒山区', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (690, '黑龙江省鸡西市滴道区', '滴道区', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (691, '黑龙江省鸡西市梨树区', '梨树区', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (692, '黑龙江省鸡西市城子河区', '城子河区', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (693, '黑龙江省鸡西市麻山区', '麻山区', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (694, '黑龙江省鸡西市鸡东县', '鸡东县', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (695, '黑龙江省鸡西市虎林市', '虎林市', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (696, '黑龙江省鸡西市密山市', '密山市', ',650,687,', 687, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (697, '黑龙江省鹤岗市', '鹤岗市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (698, '黑龙江省鹤岗市向阳区', '向阳区', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (699, '黑龙江省鹤岗市工农区', '工农区', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (700, '黑龙江省鹤岗市南山区', '南山区', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (701, '黑龙江省鹤岗市兴安区', '兴安区', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (702, '黑龙江省鹤岗市东山区', '东山区', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (703, '黑龙江省鹤岗市兴山区', '兴山区', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (704, '黑龙江省鹤岗市萝北县', '萝北县', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (705, '黑龙江省鹤岗市绥滨县', '绥滨县', ',650,697,', 697, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (706, '黑龙江省双鸭山市', '双鸭山市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (707, '黑龙江省双鸭山市尖山区', '尖山区', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (708, '黑龙江省双鸭山市岭东区', '岭东区', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (709, '黑龙江省双鸭山市四方台区', '四方台区', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (710, '黑龙江省双鸭山市宝山区', '宝山区', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (711, '黑龙江省双鸭山市集贤县', '集贤县', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (712, '黑龙江省双鸭山市友谊县', '友谊县', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (713, '黑龙江省双鸭山市宝清县', '宝清县', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (714, '黑龙江省双鸭山市饶河县', '饶河县', ',650,706,', 706, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (715, '黑龙江省大庆市', '大庆市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (716, '黑龙江省大庆市萨尔图区', '萨尔图区', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (717, '黑龙江省大庆市龙凤区', '龙凤区', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (718, '黑龙江省大庆市让胡路区', '让胡路区', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (719, '黑龙江省大庆市红岗区', '红岗区', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (720, '黑龙江省大庆市大同区', '大同区', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (721, '黑龙江省大庆市肇州县', '肇州县', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (722, '黑龙江省大庆市肇源县', '肇源县', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (723, '黑龙江省大庆市林甸县', '林甸县', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (724, '黑龙江省大庆市杜尔伯特蒙古族自治县', '杜尔伯特蒙古族自治县', ',650,715,', 715, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (725, '黑龙江省伊春市', '伊春市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (726, '黑龙江省伊春市伊春区', '伊春区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (727, '黑龙江省伊春市南岔区', '南岔区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (728, '黑龙江省伊春市友好区', '友好区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (729, '黑龙江省伊春市西林区', '西林区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (730, '黑龙江省伊春市翠峦区', '翠峦区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (731, '黑龙江省伊春市新青区', '新青区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (732, '黑龙江省伊春市美溪区', '美溪区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (733, '黑龙江省伊春市金山屯区', '金山屯区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (734, '黑龙江省伊春市五营区', '五营区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (735, '黑龙江省伊春市乌马河区', '乌马河区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (736, '黑龙江省伊春市汤旺河区', '汤旺河区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (737, '黑龙江省伊春市带岭区', '带岭区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (738, '黑龙江省伊春市乌伊岭区', '乌伊岭区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (739, '黑龙江省伊春市红星区', '红星区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (740, '黑龙江省伊春市上甘岭区', '上甘岭区', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (741, '黑龙江省伊春市嘉荫县', '嘉荫县', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (742, '黑龙江省伊春市铁力市', '铁力市', ',650,725,', 725, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (743, '黑龙江省佳木斯市', '佳木斯市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (744, '黑龙江省佳木斯市向阳区', '向阳区', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (745, '黑龙江省佳木斯市前进区', '前进区', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (746, '黑龙江省佳木斯市东风区', '东风区', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (747, '黑龙江省佳木斯市郊区', '郊区', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (748, '黑龙江省佳木斯市桦南县', '桦南县', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (749, '黑龙江省佳木斯市桦川县', '桦川县', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (750, '黑龙江省佳木斯市汤原县', '汤原县', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (751, '黑龙江省佳木斯市抚远县', '抚远县', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (752, '黑龙江省佳木斯市同江市', '同江市', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (753, '黑龙江省佳木斯市富锦市', '富锦市', ',650,743,', 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (754, '黑龙江省七台河市', '七台河市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (755, '黑龙江省七台河市新兴区', '新兴区', ',650,754,', 754, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (756, '黑龙江省七台河市桃山区', '桃山区', ',650,754,', 754, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (757, '黑龙江省七台河市茄子河区', '茄子河区', ',650,754,', 754, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (758, '黑龙江省七台河市勃利县', '勃利县', ',650,754,', 754, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (759, '黑龙江省牡丹江市', '牡丹江市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (760, '黑龙江省牡丹江市东安区', '东安区', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (761, '黑龙江省牡丹江市阳明区', '阳明区', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (762, '黑龙江省牡丹江市爱民区', '爱民区', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (763, '黑龙江省牡丹江市西安区', '西安区', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (764, '黑龙江省牡丹江市东宁县', '东宁县', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (765, '黑龙江省牡丹江市林口县', '林口县', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (766, '黑龙江省牡丹江市绥芬河市', '绥芬河市', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (767, '黑龙江省牡丹江市海林市', '海林市', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (768, '黑龙江省牡丹江市宁安市', '宁安市', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (769, '黑龙江省牡丹江市穆棱市', '穆棱市', ',650,759,', 759, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (770, '黑龙江省黑河市', '黑河市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (771, '黑龙江省黑河市爱辉区', '爱辉区', ',650,770,', 770, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (772, '黑龙江省黑河市嫩江县', '嫩江县', ',650,770,', 770, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (773, '黑龙江省黑河市逊克县', '逊克县', ',650,770,', 770, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (774, '黑龙江省黑河市孙吴县', '孙吴县', ',650,770,', 770, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (775, '黑龙江省黑河市北安市', '北安市', ',650,770,', 770, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (776, '黑龙江省黑河市五大连池市', '五大连池市', ',650,770,', 770, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (777, '黑龙江省绥化市', '绥化市', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (778, '黑龙江省绥化市北林区', '北林区', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (779, '黑龙江省绥化市望奎县', '望奎县', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (780, '黑龙江省绥化市兰西县', '兰西县', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (781, '黑龙江省绥化市青冈县', '青冈县', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (782, '黑龙江省绥化市庆安县', '庆安县', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (783, '黑龙江省绥化市明水县', '明水县', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (784, '黑龙江省绥化市绥棱县', '绥棱县', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (785, '黑龙江省绥化市安达市', '安达市', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (786, '黑龙江省绥化市肇东市', '肇东市', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (787, '黑龙江省绥化市海伦市', '海伦市', ',650,777,', 777, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (788, '黑龙江省大兴安岭地区', '大兴安岭地区', ',650,', 650, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (789, '黑龙江省大兴安岭地区呼玛县', '呼玛县', ',650,788,', 788, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (790, '黑龙江省大兴安岭地区塔河县', '塔河县', ',650,788,', 788, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (791, '黑龙江省大兴安岭地区漠河县', '漠河县', ',650,788,', 788, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (792, '上海市', '上海市', ',', NULL, 8, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (793, '上海市黄浦区', '黄浦区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (794, '上海市徐汇区', '徐汇区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (795, '上海市长宁区', '长宁区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (796, '上海市静安区', '静安区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (797, '上海市普陀区', '普陀区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (798, '上海市闸北区', '闸北区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (799, '上海市虹口区', '虹口区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (800, '上海市杨浦区', '杨浦区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (801, '上海市闵行区', '闵行区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (802, '上海市宝山区', '宝山区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (803, '上海市嘉定区', '嘉定区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (804, '上海市浦东新区', '浦东新区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (805, '上海市金山区', '金山区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (806, '上海市松江区', '松江区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (807, '上海市青浦区', '青浦区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (808, '上海市奉贤区', '奉贤区', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (809, '上海市崇明县', '崇明县', ',792,', 792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (810, '江苏省', '江苏省', ',', NULL, 9, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (811, '江苏省南京市', '南京市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (812, '江苏省南京市玄武区', '玄武区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (813, '江苏省南京市白下区', '白下区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (814, '江苏省南京市秦淮区', '秦淮区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (815, '江苏省南京市建邺区', '建邺区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (816, '江苏省南京市鼓楼区', '鼓楼区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (817, '江苏省南京市下关区', '下关区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (818, '江苏省南京市浦口区', '浦口区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (819, '江苏省南京市栖霞区', '栖霞区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (820, '江苏省南京市雨花台区', '雨花台区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (821, '江苏省南京市江宁区', '江宁区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (822, '江苏省南京市六合区', '六合区', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (823, '江苏省南京市溧水县', '溧水县', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (824, '江苏省南京市高淳县', '高淳县', ',810,811,', 811, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (825, '江苏省无锡市', '无锡市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (826, '江苏省无锡市崇安区', '崇安区', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (827, '江苏省无锡市南长区', '南长区', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (828, '江苏省无锡市北塘区', '北塘区', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (829, '江苏省无锡市锡山区', '锡山区', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (830, '江苏省无锡市惠山区', '惠山区', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (831, '江苏省无锡市滨湖区', '滨湖区', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (832, '江苏省无锡市江阴市', '江阴市', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (833, '江苏省无锡市宜兴市', '宜兴市', ',810,825,', 825, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (834, '江苏省徐州市', '徐州市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (835, '江苏省徐州市鼓楼区', '鼓楼区', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (836, '江苏省徐州市云龙区', '云龙区', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (837, '江苏省徐州市贾汪区', '贾汪区', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (838, '江苏省徐州市泉山区', '泉山区', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (839, '江苏省徐州市铜山区', '铜山区', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (840, '江苏省徐州市丰县', '丰县', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (841, '江苏省徐州市沛县', '沛县', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (842, '江苏省徐州市睢宁县', '睢宁县', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (843, '江苏省徐州市新沂市', '新沂市', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (844, '江苏省徐州市邳州市', '邳州市', ',810,834,', 834, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (845, '江苏省常州市', '常州市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (846, '江苏省常州市天宁区', '天宁区', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (847, '江苏省常州市钟楼区', '钟楼区', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (848, '江苏省常州市戚墅堰区', '戚墅堰区', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (849, '江苏省常州市新北区', '新北区', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (850, '江苏省常州市武进区', '武进区', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (851, '江苏省常州市溧阳市', '溧阳市', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (852, '江苏省常州市金坛市', '金坛市', ',810,845,', 845, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (853, '江苏省苏州市', '苏州市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (854, '江苏省苏州市虎丘区', '虎丘区', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (855, '江苏省苏州市吴中区', '吴中区', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (856, '江苏省苏州市相城区', '相城区', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (857, '江苏省苏州市姑苏区', '姑苏区', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (858, '江苏省苏州市吴江区', '吴江区', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (859, '江苏省苏州市常熟市', '常熟市', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (860, '江苏省苏州市张家港市', '张家港市', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (861, '江苏省苏州市昆山市', '昆山市', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (862, '江苏省苏州市太仓市', '太仓市', ',810,853,', 853, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (863, '江苏省南通市', '南通市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (864, '江苏省南通市崇川区', '崇川区', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (865, '江苏省南通市港闸区', '港闸区', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (866, '江苏省南通市通州区', '通州区', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (867, '江苏省南通市海安县', '海安县', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (868, '江苏省南通市如东县', '如东县', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (869, '江苏省南通市启东市', '启东市', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (870, '江苏省南通市如皋市', '如皋市', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (871, '江苏省南通市海门市', '海门市', ',810,863,', 863, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (872, '江苏省连云港市', '连云港市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (873, '江苏省连云港市连云区', '连云区', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (874, '江苏省连云港市新浦区', '新浦区', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (875, '江苏省连云港市海州区', '海州区', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (876, '江苏省连云港市赣榆县', '赣榆县', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (877, '江苏省连云港市东海县', '东海县', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (878, '江苏省连云港市灌云县', '灌云县', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (879, '江苏省连云港市灌南县', '灌南县', ',810,872,', 872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (880, '江苏省淮安市', '淮安市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (881, '江苏省淮安市清河区', '清河区', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (882, '江苏省淮安市淮安区', '淮安区', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (883, '江苏省淮安市淮阴区', '淮阴区', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (884, '江苏省淮安市清浦区', '清浦区', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (885, '江苏省淮安市涟水县', '涟水县', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (886, '江苏省淮安市洪泽县', '洪泽县', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (887, '江苏省淮安市盱眙县', '盱眙县', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (888, '江苏省淮安市金湖县', '金湖县', ',810,880,', 880, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (889, '江苏省盐城市', '盐城市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (890, '江苏省盐城市亭湖区', '亭湖区', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (891, '江苏省盐城市盐都区', '盐都区', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (892, '江苏省盐城市响水县', '响水县', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (893, '江苏省盐城市滨海县', '滨海县', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (894, '江苏省盐城市阜宁县', '阜宁县', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (895, '江苏省盐城市射阳县', '射阳县', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (896, '江苏省盐城市建湖县', '建湖县', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (897, '江苏省盐城市东台市', '东台市', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (898, '江苏省盐城市大丰市', '大丰市', ',810,889,', 889, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (899, '江苏省扬州市', '扬州市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (900, '江苏省扬州市广陵区', '广陵区', ',810,899,', 899, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (901, '江苏省扬州市邗江区', '邗江区', ',810,899,', 899, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (902, '江苏省扬州市江都区', '江都区', ',810,899,', 899, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (903, '江苏省扬州市宝应县', '宝应县', ',810,899,', 899, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (904, '江苏省扬州市仪征市', '仪征市', ',810,899,', 899, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (905, '江苏省扬州市高邮市', '高邮市', ',810,899,', 899, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (906, '江苏省镇江市', '镇江市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (907, '江苏省镇江市京口区', '京口区', ',810,906,', 906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (908, '江苏省镇江市润州区', '润州区', ',810,906,', 906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (909, '江苏省镇江市丹徒区', '丹徒区', ',810,906,', 906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (910, '江苏省镇江市丹阳市', '丹阳市', ',810,906,', 906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (911, '江苏省镇江市扬中市', '扬中市', ',810,906,', 906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (912, '江苏省镇江市句容市', '句容市', ',810,906,', 906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (913, '江苏省泰州市', '泰州市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (914, '江苏省泰州市海陵区', '海陵区', ',810,913,', 913, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (915, '江苏省泰州市高港区', '高港区', ',810,913,', 913, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (916, '江苏省泰州市兴化市', '兴化市', ',810,913,', 913, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (917, '江苏省泰州市靖江市', '靖江市', ',810,913,', 913, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (918, '江苏省泰州市泰兴市', '泰兴市', ',810,913,', 913, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (919, '江苏省泰州市姜堰市', '姜堰市', ',810,913,', 913, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (920, '江苏省宿迁市', '宿迁市', ',810,', 810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (921, '江苏省宿迁市宿城区', '宿城区', ',810,920,', 920, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (922, '江苏省宿迁市宿豫区', '宿豫区', ',810,920,', 920, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (923, '江苏省宿迁市沭阳县', '沭阳县', ',810,920,', 920, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (924, '江苏省宿迁市泗阳县', '泗阳县', ',810,920,', 920, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (925, '江苏省宿迁市泗洪县', '泗洪县', ',810,920,', 920, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (926, '浙江省', '浙江省', ',', NULL, 10, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (927, '浙江省杭州市', '杭州市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (928, '浙江省杭州市上城区', '上城区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (929, '浙江省杭州市下城区', '下城区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (930, '浙江省杭州市江干区', '江干区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (931, '浙江省杭州市拱墅区', '拱墅区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (932, '浙江省杭州市西湖区', '西湖区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (933, '浙江省杭州市滨江区', '滨江区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (934, '浙江省杭州市萧山区', '萧山区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (935, '浙江省杭州市余杭区', '余杭区', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (936, '浙江省杭州市桐庐县', '桐庐县', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (937, '浙江省杭州市淳安县', '淳安县', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (938, '浙江省杭州市建德市', '建德市', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (939, '浙江省杭州市富阳市', '富阳市', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (940, '浙江省杭州市临安市', '临安市', ',926,927,', 927, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (941, '浙江省宁波市', '宁波市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (942, '浙江省宁波市海曙区', '海曙区', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (943, '浙江省宁波市江东区', '江东区', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (944, '浙江省宁波市江北区', '江北区', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (945, '浙江省宁波市北仑区', '北仑区', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (946, '浙江省宁波市镇海区', '镇海区', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (947, '浙江省宁波市鄞州区', '鄞州区', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (948, '浙江省宁波市象山县', '象山县', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (949, '浙江省宁波市宁海县', '宁海县', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (950, '浙江省宁波市余姚市', '余姚市', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (951, '浙江省宁波市慈溪市', '慈溪市', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (952, '浙江省宁波市奉化市', '奉化市', ',926,941,', 941, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (953, '浙江省温州市', '温州市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (954, '浙江省温州市鹿城区', '鹿城区', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (955, '浙江省温州市龙湾区', '龙湾区', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (956, '浙江省温州市瓯海区', '瓯海区', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (957, '浙江省温州市洞头县', '洞头县', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (958, '浙江省温州市永嘉县', '永嘉县', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (959, '浙江省温州市平阳县', '平阳县', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (960, '浙江省温州市苍南县', '苍南县', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (961, '浙江省温州市文成县', '文成县', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (962, '浙江省温州市泰顺县', '泰顺县', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (963, '浙江省温州市瑞安市', '瑞安市', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (964, '浙江省温州市乐清市', '乐清市', ',926,953,', 953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (965, '浙江省嘉兴市', '嘉兴市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (966, '浙江省嘉兴市南湖区', '南湖区', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (967, '浙江省嘉兴市秀洲区', '秀洲区', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (968, '浙江省嘉兴市嘉善县', '嘉善县', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (969, '浙江省嘉兴市海盐县', '海盐县', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (970, '浙江省嘉兴市海宁市', '海宁市', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (971, '浙江省嘉兴市平湖市', '平湖市', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (972, '浙江省嘉兴市桐乡市', '桐乡市', ',926,965,', 965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (973, '浙江省湖州市', '湖州市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (974, '浙江省湖州市吴兴区', '吴兴区', ',926,973,', 973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (975, '浙江省湖州市南浔区', '南浔区', ',926,973,', 973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (976, '浙江省湖州市德清县', '德清县', ',926,973,', 973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (977, '浙江省湖州市长兴县', '长兴县', ',926,973,', 973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (978, '浙江省湖州市安吉县', '安吉县', ',926,973,', 973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (979, '浙江省绍兴市', '绍兴市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (980, '浙江省绍兴市越城区', '越城区', ',926,979,', 979, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (981, '浙江省绍兴市绍兴县', '绍兴县', ',926,979,', 979, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (982, '浙江省绍兴市新昌县', '新昌县', ',926,979,', 979, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (983, '浙江省绍兴市诸暨市', '诸暨市', ',926,979,', 979, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (984, '浙江省绍兴市上虞市', '上虞市', ',926,979,', 979, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (985, '浙江省绍兴市嵊州市', '嵊州市', ',926,979,', 979, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (986, '浙江省金华市', '金华市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (987, '浙江省金华市婺城区', '婺城区', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (988, '浙江省金华市金东区', '金东区', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (989, '浙江省金华市武义县', '武义县', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (990, '浙江省金华市浦江县', '浦江县', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (991, '浙江省金华市磐安县', '磐安县', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (992, '浙江省金华市兰溪市', '兰溪市', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (993, '浙江省金华市义乌市', '义乌市', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (994, '浙江省金华市东阳市', '东阳市', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (995, '浙江省金华市永康市', '永康市', ',926,986,', 986, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (996, '浙江省衢州市', '衢州市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (997, '浙江省衢州市柯城区', '柯城区', ',926,996,', 996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (998, '浙江省衢州市衢江区', '衢江区', ',926,996,', 996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (999, '浙江省衢州市常山县', '常山县', ',926,996,', 996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1000, '浙江省衢州市开化县', '开化县', ',926,996,', 996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1001, '浙江省衢州市龙游县', '龙游县', ',926,996,', 996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1002, '浙江省衢州市江山市', '江山市', ',926,996,', 996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1003, '浙江省舟山市', '舟山市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1004, '浙江省舟山市定海区', '定海区', ',926,1003,', 1003, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1005, '浙江省舟山市普陀区', '普陀区', ',926,1003,', 1003, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1006, '浙江省舟山市岱山县', '岱山县', ',926,1003,', 1003, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1007, '浙江省舟山市嵊泗县', '嵊泗县', ',926,1003,', 1003, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1008, '浙江省台州市', '台州市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1009, '浙江省台州市椒江区', '椒江区', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1010, '浙江省台州市黄岩区', '黄岩区', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1011, '浙江省台州市路桥区', '路桥区', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1012, '浙江省台州市玉环县', '玉环县', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1013, '浙江省台州市三门县', '三门县', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1014, '浙江省台州市天台县', '天台县', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1015, '浙江省台州市仙居县', '仙居县', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1016, '浙江省台州市温岭市', '温岭市', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1017, '浙江省台州市临海市', '临海市', ',926,1008,', 1008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1018, '浙江省丽水市', '丽水市', ',926,', 926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1019, '浙江省丽水市莲都区', '莲都区', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1020, '浙江省丽水市青田县', '青田县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1021, '浙江省丽水市缙云县', '缙云县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1022, '浙江省丽水市遂昌县', '遂昌县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1023, '浙江省丽水市松阳县', '松阳县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1024, '浙江省丽水市云和县', '云和县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1025, '浙江省丽水市庆元县', '庆元县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1026, '浙江省丽水市景宁畲族自治县', '景宁畲族自治县', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1027, '浙江省丽水市龙泉市', '龙泉市', ',926,1018,', 1018, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1028, '安徽省', '安徽省', ',', NULL, 11, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1029, '安徽省合肥市', '合肥市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1030, '安徽省合肥市瑶海区', '瑶海区', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1031, '安徽省合肥市庐阳区', '庐阳区', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1032, '安徽省合肥市蜀山区', '蜀山区', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1033, '安徽省合肥市包河区', '包河区', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1034, '安徽省合肥市长丰县', '长丰县', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1035, '安徽省合肥市肥东县', '肥东县', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1036, '安徽省合肥市肥西县', '肥西县', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1037, '安徽省合肥市庐江县', '庐江县', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1038, '安徽省合肥市巢湖市', '巢湖市', ',1028,1029,', 1029, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1039, '安徽省芜湖市', '芜湖市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1040, '安徽省芜湖市镜湖区', '镜湖区', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1041, '安徽省芜湖市弋江区', '弋江区', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1042, '安徽省芜湖市鸠江区', '鸠江区', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1043, '安徽省芜湖市三山区', '三山区', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1044, '安徽省芜湖市芜湖县', '芜湖县', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1045, '安徽省芜湖市繁昌县', '繁昌县', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1046, '安徽省芜湖市南陵县', '南陵县', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1047, '安徽省芜湖市无为县', '无为县', ',1028,1039,', 1039, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1048, '安徽省蚌埠市', '蚌埠市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1049, '安徽省蚌埠市龙子湖区', '龙子湖区', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1050, '安徽省蚌埠市蚌山区', '蚌山区', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1051, '安徽省蚌埠市禹会区', '禹会区', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1052, '安徽省蚌埠市淮上区', '淮上区', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1053, '安徽省蚌埠市怀远县', '怀远县', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1054, '安徽省蚌埠市五河县', '五河县', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1055, '安徽省蚌埠市固镇县', '固镇县', ',1028,1048,', 1048, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1056, '安徽省淮南市', '淮南市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1057, '安徽省淮南市大通区', '大通区', ',1028,1056,', 1056, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1058, '安徽省淮南市田家庵区', '田家庵区', ',1028,1056,', 1056, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1059, '安徽省淮南市谢家集区', '谢家集区', ',1028,1056,', 1056, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1060, '安徽省淮南市八公山区', '八公山区', ',1028,1056,', 1056, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1061, '安徽省淮南市潘集区', '潘集区', ',1028,1056,', 1056, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1062, '安徽省淮南市凤台县', '凤台县', ',1028,1056,', 1056, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1063, '安徽省马鞍山市', '马鞍山市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1064, '安徽省马鞍山市花山区', '花山区', ',1028,1063,', 1063, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1065, '安徽省马鞍山市雨山区', '雨山区', ',1028,1063,', 1063, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1066, '安徽省马鞍山市博望区', '博望区', ',1028,1063,', 1063, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1067, '安徽省马鞍山市当涂县', '当涂县', ',1028,1063,', 1063, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1068, '安徽省马鞍山市含山县', '含山县', ',1028,1063,', 1063, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1069, '安徽省马鞍山市和县', '和县', ',1028,1063,', 1063, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1070, '安徽省淮北市', '淮北市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1071, '安徽省淮北市杜集区', '杜集区', ',1028,1070,', 1070, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1072, '安徽省淮北市相山区', '相山区', ',1028,1070,', 1070, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1073, '安徽省淮北市烈山区', '烈山区', ',1028,1070,', 1070, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1074, '安徽省淮北市濉溪县', '濉溪县', ',1028,1070,', 1070, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1075, '安徽省铜陵市', '铜陵市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1076, '安徽省铜陵市铜官山区', '铜官山区', ',1028,1075,', 1075, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1077, '安徽省铜陵市狮子山区', '狮子山区', ',1028,1075,', 1075, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1078, '安徽省铜陵市郊区', '郊区', ',1028,1075,', 1075, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1079, '安徽省铜陵市铜陵县', '铜陵县', ',1028,1075,', 1075, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1080, '安徽省安庆市', '安庆市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1081, '安徽省安庆市迎江区', '迎江区', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1082, '安徽省安庆市大观区', '大观区', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1083, '安徽省安庆市宜秀区', '宜秀区', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1084, '安徽省安庆市怀宁县', '怀宁县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1085, '安徽省安庆市枞阳县', '枞阳县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1086, '安徽省安庆市潜山县', '潜山县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1087, '安徽省安庆市太湖县', '太湖县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1088, '安徽省安庆市宿松县', '宿松县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1089, '安徽省安庆市望江县', '望江县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1090, '安徽省安庆市岳西县', '岳西县', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1091, '安徽省安庆市桐城市', '桐城市', ',1028,1080,', 1080, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1092, '安徽省黄山市', '黄山市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1093, '安徽省黄山市屯溪区', '屯溪区', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1094, '安徽省黄山市黄山区', '黄山区', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1095, '安徽省黄山市徽州区', '徽州区', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1096, '安徽省黄山市歙县', '歙县', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1097, '安徽省黄山市休宁县', '休宁县', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1098, '安徽省黄山市黟县', '黟县', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1099, '安徽省黄山市祁门县', '祁门县', ',1028,1092,', 1092, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1100, '安徽省滁州市', '滁州市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1101, '安徽省滁州市琅琊区', '琅琊区', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1102, '安徽省滁州市南谯区', '南谯区', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1103, '安徽省滁州市来安县', '来安县', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1104, '安徽省滁州市全椒县', '全椒县', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1105, '安徽省滁州市定远县', '定远县', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1106, '安徽省滁州市凤阳县', '凤阳县', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1107, '安徽省滁州市天长市', '天长市', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1108, '安徽省滁州市明光市', '明光市', ',1028,1100,', 1100, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1109, '安徽省阜阳市', '阜阳市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1110, '安徽省阜阳市颍州区', '颍州区', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1111, '安徽省阜阳市颍东区', '颍东区', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1112, '安徽省阜阳市颍泉区', '颍泉区', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1113, '安徽省阜阳市临泉县', '临泉县', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1114, '安徽省阜阳市太和县', '太和县', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1115, '安徽省阜阳市阜南县', '阜南县', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1116, '安徽省阜阳市颍上县', '颍上县', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1117, '安徽省阜阳市界首市', '界首市', ',1028,1109,', 1109, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1118, '安徽省宿州市', '宿州市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1119, '安徽省宿州市埇桥区', '埇桥区', ',1028,1118,', 1118, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1120, '安徽省宿州市砀山县', '砀山县', ',1028,1118,', 1118, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1121, '安徽省宿州市萧县', '萧县', ',1028,1118,', 1118, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1122, '安徽省宿州市灵璧县', '灵璧县', ',1028,1118,', 1118, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1123, '安徽省宿州市泗县', '泗县', ',1028,1118,', 1118, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1124, '安徽省六安市', '六安市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1125, '安徽省六安市金安区', '金安区', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1126, '安徽省六安市裕安区', '裕安区', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1127, '安徽省六安市寿县', '寿县', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1128, '安徽省六安市霍邱县', '霍邱县', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1129, '安徽省六安市舒城县', '舒城县', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1130, '安徽省六安市金寨县', '金寨县', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1131, '安徽省六安市霍山县', '霍山县', ',1028,1124,', 1124, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1132, '安徽省亳州市', '亳州市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1133, '安徽省亳州市谯城区', '谯城区', ',1028,1132,', 1132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1134, '安徽省亳州市涡阳县', '涡阳县', ',1028,1132,', 1132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1135, '安徽省亳州市蒙城县', '蒙城县', ',1028,1132,', 1132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1136, '安徽省亳州市利辛县', '利辛县', ',1028,1132,', 1132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1137, '安徽省池州市', '池州市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1138, '安徽省池州市贵池区', '贵池区', ',1028,1137,', 1137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1139, '安徽省池州市东至县', '东至县', ',1028,1137,', 1137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1140, '安徽省池州市石台县', '石台县', ',1028,1137,', 1137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1141, '安徽省池州市青阳县', '青阳县', ',1028,1137,', 1137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1142, '安徽省宣城市', '宣城市', ',1028,', 1028, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1143, '安徽省宣城市宣州区', '宣州区', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1144, '安徽省宣城市郎溪县', '郎溪县', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1145, '安徽省宣城市广德县', '广德县', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1146, '安徽省宣城市泾县', '泾县', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1147, '安徽省宣城市绩溪县', '绩溪县', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1148, '安徽省宣城市旌德县', '旌德县', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1149, '安徽省宣城市宁国市', '宁国市', ',1028,1142,', 1142, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1150, '福建省', '福建省', ',', NULL, 12, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1151, '福建省福州市', '福州市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1152, '福建省福州市鼓楼区', '鼓楼区', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1153, '福建省福州市台江区', '台江区', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1154, '福建省福州市仓山区', '仓山区', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1155, '福建省福州市马尾区', '马尾区', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1156, '福建省福州市晋安区', '晋安区', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1157, '福建省福州市闽侯县', '闽侯县', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1158, '福建省福州市连江县', '连江县', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1159, '福建省福州市罗源县', '罗源县', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1160, '福建省福州市闽清县', '闽清县', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1161, '福建省福州市永泰县', '永泰县', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1162, '福建省福州市平潭县', '平潭县', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1163, '福建省福州市福清市', '福清市', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1164, '福建省福州市长乐市', '长乐市', ',1150,1151,', 1151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1165, '福建省厦门市', '厦门市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1166, '福建省厦门市思明区', '思明区', ',1150,1165,', 1165, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1167, '福建省厦门市海沧区', '海沧区', ',1150,1165,', 1165, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1168, '福建省厦门市湖里区', '湖里区', ',1150,1165,', 1165, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1169, '福建省厦门市集美区', '集美区', ',1150,1165,', 1165, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1170, '福建省厦门市同安区', '同安区', ',1150,1165,', 1165, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1171, '福建省厦门市翔安区', '翔安区', ',1150,1165,', 1165, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1172, '福建省莆田市', '莆田市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1173, '福建省莆田市城厢区', '城厢区', ',1150,1172,', 1172, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1174, '福建省莆田市涵江区', '涵江区', ',1150,1172,', 1172, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1175, '福建省莆田市荔城区', '荔城区', ',1150,1172,', 1172, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1176, '福建省莆田市秀屿区', '秀屿区', ',1150,1172,', 1172, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1177, '福建省莆田市仙游县', '仙游县', ',1150,1172,', 1172, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1178, '福建省三明市', '三明市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1179, '福建省三明市梅列区', '梅列区', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1180, '福建省三明市三元区', '三元区', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1181, '福建省三明市明溪县', '明溪县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1182, '福建省三明市清流县', '清流县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1183, '福建省三明市宁化县', '宁化县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1184, '福建省三明市大田县', '大田县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1185, '福建省三明市尤溪县', '尤溪县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1186, '福建省三明市沙县', '沙县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1187, '福建省三明市将乐县', '将乐县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1188, '福建省三明市泰宁县', '泰宁县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1189, '福建省三明市建宁县', '建宁县', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1190, '福建省三明市永安市', '永安市', ',1150,1178,', 1178, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1191, '福建省泉州市', '泉州市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1192, '福建省泉州市鲤城区', '鲤城区', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1193, '福建省泉州市丰泽区', '丰泽区', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1194, '福建省泉州市洛江区', '洛江区', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1195, '福建省泉州市泉港区', '泉港区', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1196, '福建省泉州市惠安县', '惠安县', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1197, '福建省泉州市安溪县', '安溪县', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1198, '福建省泉州市永春县', '永春县', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1199, '福建省泉州市德化县', '德化县', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1200, '福建省泉州市金门县', '金门县', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1201, '福建省泉州市石狮市', '石狮市', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1202, '福建省泉州市晋江市', '晋江市', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1203, '福建省泉州市南安市', '南安市', ',1150,1191,', 1191, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1204, '福建省漳州市', '漳州市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1205, '福建省漳州市芗城区', '芗城区', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1206, '福建省漳州市龙文区', '龙文区', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1207, '福建省漳州市云霄县', '云霄县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1208, '福建省漳州市漳浦县', '漳浦县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1209, '福建省漳州市诏安县', '诏安县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1210, '福建省漳州市长泰县', '长泰县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1211, '福建省漳州市东山县', '东山县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1212, '福建省漳州市南靖县', '南靖县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1213, '福建省漳州市平和县', '平和县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1214, '福建省漳州市华安县', '华安县', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1215, '福建省漳州市龙海市', '龙海市', ',1150,1204,', 1204, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1216, '福建省南平市', '南平市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1217, '福建省南平市延平区', '延平区', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1218, '福建省南平市顺昌县', '顺昌县', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1219, '福建省南平市浦城县', '浦城县', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1220, '福建省南平市光泽县', '光泽县', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1221, '福建省南平市松溪县', '松溪县', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1222, '福建省南平市政和县', '政和县', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1223, '福建省南平市邵武市', '邵武市', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1224, '福建省南平市武夷山市', '武夷山市', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1225, '福建省南平市建瓯市', '建瓯市', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1226, '福建省南平市建阳市', '建阳市', ',1150,1216,', 1216, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1227, '福建省龙岩市', '龙岩市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1228, '福建省龙岩市新罗区', '新罗区', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1229, '福建省龙岩市长汀县', '长汀县', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1230, '福建省龙岩市永定县', '永定县', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1231, '福建省龙岩市上杭县', '上杭县', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1232, '福建省龙岩市武平县', '武平县', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1233, '福建省龙岩市连城县', '连城县', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1234, '福建省龙岩市漳平市', '漳平市', ',1150,1227,', 1227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1235, '福建省宁德市', '宁德市', ',1150,', 1150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1236, '福建省宁德市蕉城区', '蕉城区', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1237, '福建省宁德市霞浦县', '霞浦县', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1238, '福建省宁德市古田县', '古田县', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1239, '福建省宁德市屏南县', '屏南县', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1240, '福建省宁德市寿宁县', '寿宁县', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1241, '福建省宁德市周宁县', '周宁县', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1242, '福建省宁德市柘荣县', '柘荣县', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1243, '福建省宁德市福安市', '福安市', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1244, '福建省宁德市福鼎市', '福鼎市', ',1150,1235,', 1235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1245, '江西省', '江西省', ',', NULL, 13, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1246, '江西省南昌市', '南昌市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1247, '江西省南昌市东湖区', '东湖区', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1248, '江西省南昌市西湖区', '西湖区', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1249, '江西省南昌市青云谱区', '青云谱区', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1250, '江西省南昌市湾里区', '湾里区', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1251, '江西省南昌市青山湖区', '青山湖区', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1252, '江西省南昌市南昌县', '南昌县', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1253, '江西省南昌市新建县', '新建县', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1254, '江西省南昌市安义县', '安义县', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1255, '江西省南昌市进贤县', '进贤县', ',1245,1246,', 1246, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1256, '江西省景德镇市', '景德镇市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1257, '江西省景德镇市昌江区', '昌江区', ',1245,1256,', 1256, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1258, '江西省景德镇市珠山区', '珠山区', ',1245,1256,', 1256, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1259, '江西省景德镇市浮梁县', '浮梁县', ',1245,1256,', 1256, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1260, '江西省景德镇市乐平市', '乐平市', ',1245,1256,', 1256, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1261, '江西省萍乡市', '萍乡市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1262, '江西省萍乡市安源区', '安源区', ',1245,1261,', 1261, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1263, '江西省萍乡市湘东区', '湘东区', ',1245,1261,', 1261, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1264, '江西省萍乡市莲花县', '莲花县', ',1245,1261,', 1261, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1265, '江西省萍乡市上栗县', '上栗县', ',1245,1261,', 1261, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1266, '江西省萍乡市芦溪县', '芦溪县', ',1245,1261,', 1261, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1267, '江西省九江市', '九江市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1268, '江西省九江市庐山区', '庐山区', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1269, '江西省九江市浔阳区', '浔阳区', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1270, '江西省九江市九江县', '九江县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1271, '江西省九江市武宁县', '武宁县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1272, '江西省九江市修水县', '修水县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1273, '江西省九江市永修县', '永修县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1274, '江西省九江市德安县', '德安县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1275, '江西省九江市星子县', '星子县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1276, '江西省九江市都昌县', '都昌县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1277, '江西省九江市湖口县', '湖口县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1278, '江西省九江市彭泽县', '彭泽县', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1279, '江西省九江市瑞昌市', '瑞昌市', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1280, '江西省九江市共青城市', '共青城市', ',1245,1267,', 1267, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1281, '江西省新余市', '新余市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1282, '江西省新余市渝水区', '渝水区', ',1245,1281,', 1281, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1283, '江西省新余市分宜县', '分宜县', ',1245,1281,', 1281, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1284, '江西省鹰潭市', '鹰潭市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1285, '江西省鹰潭市月湖区', '月湖区', ',1245,1284,', 1284, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1286, '江西省鹰潭市余江县', '余江县', ',1245,1284,', 1284, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1287, '江西省鹰潭市贵溪市', '贵溪市', ',1245,1284,', 1284, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1288, '江西省赣州市', '赣州市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1289, '江西省赣州市章贡区', '章贡区', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1290, '江西省赣州市赣县', '赣县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1291, '江西省赣州市信丰县', '信丰县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1292, '江西省赣州市大余县', '大余县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1293, '江西省赣州市上犹县', '上犹县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1294, '江西省赣州市崇义县', '崇义县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1295, '江西省赣州市安远县', '安远县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1296, '江西省赣州市龙南县', '龙南县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1297, '江西省赣州市定南县', '定南县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1298, '江西省赣州市全南县', '全南县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1299, '江西省赣州市宁都县', '宁都县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1300, '江西省赣州市于都县', '于都县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1301, '江西省赣州市兴国县', '兴国县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1302, '江西省赣州市会昌县', '会昌县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1303, '江西省赣州市寻乌县', '寻乌县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1304, '江西省赣州市石城县', '石城县', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1305, '江西省赣州市瑞金市', '瑞金市', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1306, '江西省赣州市南康市', '南康市', ',1245,1288,', 1288, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1307, '江西省吉安市', '吉安市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1308, '江西省吉安市吉州区', '吉州区', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1309, '江西省吉安市青原区', '青原区', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1310, '江西省吉安市吉安县', '吉安县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1311, '江西省吉安市吉水县', '吉水县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1312, '江西省吉安市峡江县', '峡江县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1313, '江西省吉安市新干县', '新干县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1314, '江西省吉安市永丰县', '永丰县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1315, '江西省吉安市泰和县', '泰和县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1316, '江西省吉安市遂川县', '遂川县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1317, '江西省吉安市万安县', '万安县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1318, '江西省吉安市安福县', '安福县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1319, '江西省吉安市永新县', '永新县', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1320, '江西省吉安市井冈山市', '井冈山市', ',1245,1307,', 1307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1321, '江西省宜春市', '宜春市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1322, '江西省宜春市袁州区', '袁州区', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1323, '江西省宜春市奉新县', '奉新县', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1324, '江西省宜春市万载县', '万载县', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1325, '江西省宜春市上高县', '上高县', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1326, '江西省宜春市宜丰县', '宜丰县', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1327, '江西省宜春市靖安县', '靖安县', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1328, '江西省宜春市铜鼓县', '铜鼓县', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1329, '江西省宜春市丰城市', '丰城市', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1330, '江西省宜春市樟树市', '樟树市', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1331, '江西省宜春市高安市', '高安市', ',1245,1321,', 1321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1332, '江西省抚州市', '抚州市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1333, '江西省抚州市临川区', '临川区', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1334, '江西省抚州市南城县', '南城县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1335, '江西省抚州市黎川县', '黎川县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1336, '江西省抚州市南丰县', '南丰县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1337, '江西省抚州市崇仁县', '崇仁县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1338, '江西省抚州市乐安县', '乐安县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1339, '江西省抚州市宜黄县', '宜黄县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1340, '江西省抚州市金溪县', '金溪县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1341, '江西省抚州市资溪县', '资溪县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1342, '江西省抚州市东乡县', '东乡县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1343, '江西省抚州市广昌县', '广昌县', ',1245,1332,', 1332, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1344, '江西省上饶市', '上饶市', ',1245,', 1245, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1345, '江西省上饶市信州区', '信州区', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1346, '江西省上饶市上饶县', '上饶县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1347, '江西省上饶市广丰县', '广丰县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1348, '江西省上饶市玉山县', '玉山县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1349, '江西省上饶市铅山县', '铅山县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1350, '江西省上饶市横峰县', '横峰县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1351, '江西省上饶市弋阳县', '弋阳县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1352, '江西省上饶市余干县', '余干县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1353, '江西省上饶市鄱阳县', '鄱阳县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1354, '江西省上饶市万年县', '万年县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1355, '江西省上饶市婺源县', '婺源县', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1356, '江西省上饶市德兴市', '德兴市', ',1245,1344,', 1344, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1357, '山东省', '山东省', ',', NULL, 14, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1358, '山东省济南市', '济南市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1359, '山东省济南市历下区', '历下区', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1360, '山东省济南市市中区', '市中区', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1361, '山东省济南市槐荫区', '槐荫区', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1362, '山东省济南市天桥区', '天桥区', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1363, '山东省济南市历城区', '历城区', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1364, '山东省济南市长清区', '长清区', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1365, '山东省济南市平阴县', '平阴县', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1366, '山东省济南市济阳县', '济阳县', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1367, '山东省济南市商河县', '商河县', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1368, '山东省济南市章丘市', '章丘市', ',1357,1358,', 1358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1369, '山东省青岛市', '青岛市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1370, '山东省青岛市市南区', '市南区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1371, '山东省青岛市市北区', '市北区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1372, '山东省青岛市四方区', '四方区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1373, '山东省青岛市黄岛区', '黄岛区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1374, '山东省青岛市崂山区', '崂山区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1375, '山东省青岛市李沧区', '李沧区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1376, '山东省青岛市城阳区', '城阳区', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1377, '山东省青岛市胶州市', '胶州市', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1378, '山东省青岛市即墨市', '即墨市', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1379, '山东省青岛市平度市', '平度市', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1380, '山东省青岛市胶南市', '胶南市', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1381, '山东省青岛市莱西市', '莱西市', ',1357,1369,', 1369, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1382, '山东省淄博市', '淄博市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1383, '山东省淄博市淄川区', '淄川区', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1384, '山东省淄博市张店区', '张店区', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1385, '山东省淄博市博山区', '博山区', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1386, '山东省淄博市临淄区', '临淄区', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1387, '山东省淄博市周村区', '周村区', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1388, '山东省淄博市桓台县', '桓台县', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1389, '山东省淄博市高青县', '高青县', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1390, '山东省淄博市沂源县', '沂源县', ',1357,1382,', 1382, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1391, '山东省枣庄市', '枣庄市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1392, '山东省枣庄市市中区', '市中区', ',1357,1391,', 1391, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1393, '山东省枣庄市薛城区', '薛城区', ',1357,1391,', 1391, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1394, '山东省枣庄市峄城区', '峄城区', ',1357,1391,', 1391, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1395, '山东省枣庄市台儿庄区', '台儿庄区', ',1357,1391,', 1391, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1396, '山东省枣庄市山亭区', '山亭区', ',1357,1391,', 1391, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1397, '山东省枣庄市滕州市', '滕州市', ',1357,1391,', 1391, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1398, '山东省东营市', '东营市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1399, '山东省东营市东营区', '东营区', ',1357,1398,', 1398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1400, '山东省东营市河口区', '河口区', ',1357,1398,', 1398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1401, '山东省东营市垦利县', '垦利县', ',1357,1398,', 1398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1402, '山东省东营市利津县', '利津县', ',1357,1398,', 1398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1403, '山东省东营市广饶县', '广饶县', ',1357,1398,', 1398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1404, '山东省烟台市', '烟台市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1405, '山东省烟台市芝罘区', '芝罘区', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1406, '山东省烟台市福山区', '福山区', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1407, '山东省烟台市牟平区', '牟平区', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1408, '山东省烟台市莱山区', '莱山区', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1409, '山东省烟台市长岛县', '长岛县', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1410, '山东省烟台市龙口市', '龙口市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1411, '山东省烟台市莱阳市', '莱阳市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1412, '山东省烟台市莱州市', '莱州市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1413, '山东省烟台市蓬莱市', '蓬莱市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1414, '山东省烟台市招远市', '招远市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1415, '山东省烟台市栖霞市', '栖霞市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1416, '山东省烟台市海阳市', '海阳市', ',1357,1404,', 1404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1417, '山东省潍坊市', '潍坊市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1418, '山东省潍坊市潍城区', '潍城区', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1419, '山东省潍坊市寒亭区', '寒亭区', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1420, '山东省潍坊市坊子区', '坊子区', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1421, '山东省潍坊市奎文区', '奎文区', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1422, '山东省潍坊市临朐县', '临朐县', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1423, '山东省潍坊市昌乐县', '昌乐县', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1424, '山东省潍坊市青州市', '青州市', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1425, '山东省潍坊市诸城市', '诸城市', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1426, '山东省潍坊市寿光市', '寿光市', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1427, '山东省潍坊市安丘市', '安丘市', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1428, '山东省潍坊市高密市', '高密市', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1429, '山东省潍坊市昌邑市', '昌邑市', ',1357,1417,', 1417, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1430, '山东省济宁市', '济宁市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1431, '山东省济宁市市中区', '市中区', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1432, '山东省济宁市任城区', '任城区', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1433, '山东省济宁市微山县', '微山县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1434, '山东省济宁市鱼台县', '鱼台县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1435, '山东省济宁市金乡县', '金乡县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1436, '山东省济宁市嘉祥县', '嘉祥县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1437, '山东省济宁市汶上县', '汶上县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1438, '山东省济宁市泗水县', '泗水县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1439, '山东省济宁市梁山县', '梁山县', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1440, '山东省济宁市曲阜市', '曲阜市', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1441, '山东省济宁市兖州市', '兖州市', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1442, '山东省济宁市邹城市', '邹城市', ',1357,1430,', 1430, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1443, '山东省泰安市', '泰安市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1444, '山东省泰安市泰山区', '泰山区', ',1357,1443,', 1443, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1445, '山东省泰安市岱岳区', '岱岳区', ',1357,1443,', 1443, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1446, '山东省泰安市宁阳县', '宁阳县', ',1357,1443,', 1443, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1447, '山东省泰安市东平县', '东平县', ',1357,1443,', 1443, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1448, '山东省泰安市新泰市', '新泰市', ',1357,1443,', 1443, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1449, '山东省泰安市肥城市', '肥城市', ',1357,1443,', 1443, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1450, '山东省威海市', '威海市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1451, '山东省威海市环翠区', '环翠区', ',1357,1450,', 1450, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1452, '山东省威海市文登市', '文登市', ',1357,1450,', 1450, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1453, '山东省威海市荣成市', '荣成市', ',1357,1450,', 1450, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1454, '山东省威海市乳山市', '乳山市', ',1357,1450,', 1450, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1455, '山东省日照市', '日照市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1456, '山东省日照市东港区', '东港区', ',1357,1455,', 1455, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1457, '山东省日照市岚山区', '岚山区', ',1357,1455,', 1455, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1458, '山东省日照市五莲县', '五莲县', ',1357,1455,', 1455, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1459, '山东省日照市莒县', '莒县', ',1357,1455,', 1455, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1460, '山东省莱芜市', '莱芜市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1461, '山东省莱芜市莱城区', '莱城区', ',1357,1460,', 1460, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1462, '山东省莱芜市钢城区', '钢城区', ',1357,1460,', 1460, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1463, '山东省临沂市', '临沂市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1464, '山东省临沂市兰山区', '兰山区', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1465, '山东省临沂市罗庄区', '罗庄区', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1466, '山东省临沂市河东区', '河东区', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1467, '山东省临沂市沂南县', '沂南县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1468, '山东省临沂市郯城县', '郯城县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1469, '山东省临沂市沂水县', '沂水县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1470, '山东省临沂市苍山县', '苍山县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1471, '山东省临沂市费县', '费县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1472, '山东省临沂市平邑县', '平邑县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1473, '山东省临沂市莒南县', '莒南县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1474, '山东省临沂市蒙阴县', '蒙阴县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1475, '山东省临沂市临沭县', '临沭县', ',1357,1463,', 1463, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1476, '山东省德州市', '德州市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1477, '山东省德州市德城区', '德城区', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1478, '山东省德州市陵县', '陵县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1479, '山东省德州市宁津县', '宁津县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1480, '山东省德州市庆云县', '庆云县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1481, '山东省德州市临邑县', '临邑县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1482, '山东省德州市齐河县', '齐河县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1483, '山东省德州市平原县', '平原县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1484, '山东省德州市夏津县', '夏津县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1485, '山东省德州市武城县', '武城县', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1486, '山东省德州市乐陵市', '乐陵市', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1487, '山东省德州市禹城市', '禹城市', ',1357,1476,', 1476, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1488, '山东省聊城市', '聊城市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1489, '山东省聊城市东昌府区', '东昌府区', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1490, '山东省聊城市阳谷县', '阳谷县', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1491, '山东省聊城市莘县', '莘县', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1492, '山东省聊城市茌平县', '茌平县', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1493, '山东省聊城市东阿县', '东阿县', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1494, '山东省聊城市冠县', '冠县', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1495, '山东省聊城市高唐县', '高唐县', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1496, '山东省聊城市临清市', '临清市', ',1357,1488,', 1488, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1497, '山东省滨州市', '滨州市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1498, '山东省滨州市滨城区', '滨城区', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1499, '山东省滨州市惠民县', '惠民县', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1500, '山东省滨州市阳信县', '阳信县', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1501, '山东省滨州市无棣县', '无棣县', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1502, '山东省滨州市沾化县', '沾化县', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1503, '山东省滨州市博兴县', '博兴县', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1504, '山东省滨州市邹平县', '邹平县', ',1357,1497,', 1497, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1505, '山东省菏泽市', '菏泽市', ',1357,', 1357, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1506, '山东省菏泽市牡丹区', '牡丹区', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1507, '山东省菏泽市曹县', '曹县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1508, '山东省菏泽市单县', '单县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1509, '山东省菏泽市成武县', '成武县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1510, '山东省菏泽市巨野县', '巨野县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1511, '山东省菏泽市郓城县', '郓城县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1512, '山东省菏泽市鄄城县', '鄄城县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1513, '山东省菏泽市定陶县', '定陶县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1514, '山东省菏泽市东明县', '东明县', ',1357,1505,', 1505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1515, '河南省', '河南省', ',', NULL, 15, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1516, '河南省郑州市', '郑州市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1517, '河南省郑州市中原区', '中原区', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1518, '河南省郑州市二七区', '二七区', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1519, '河南省郑州市管城回族区', '管城回族区', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1520, '河南省郑州市金水区', '金水区', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1521, '河南省郑州市上街区', '上街区', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1522, '河南省郑州市惠济区', '惠济区', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1523, '河南省郑州市中牟县', '中牟县', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1524, '河南省郑州市巩义市', '巩义市', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1525, '河南省郑州市荥阳市', '荥阳市', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1526, '河南省郑州市新密市', '新密市', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1527, '河南省郑州市新郑市', '新郑市', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1528, '河南省郑州市登封市', '登封市', ',1515,1516,', 1516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1529, '河南省开封市', '开封市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1530, '河南省开封市龙亭区', '龙亭区', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1531, '河南省开封市顺河回族区', '顺河回族区', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1532, '河南省开封市鼓楼区', '鼓楼区', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1533, '河南省开封市禹王台区', '禹王台区', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1534, '河南省开封市金明区', '金明区', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1535, '河南省开封市杞县', '杞县', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1536, '河南省开封市通许县', '通许县', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1537, '河南省开封市尉氏县', '尉氏县', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1538, '河南省开封市开封县', '开封县', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1539, '河南省开封市兰考县', '兰考县', ',1515,1529,', 1529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1540, '河南省洛阳市', '洛阳市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1541, '河南省洛阳市老城区', '老城区', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1542, '河南省洛阳市西工区', '西工区', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1543, '河南省洛阳市瀍河回族区', '瀍河回族区', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1544, '河南省洛阳市涧西区', '涧西区', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1545, '河南省洛阳市吉利区', '吉利区', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1546, '河南省洛阳市洛龙区', '洛龙区', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1547, '河南省洛阳市孟津县', '孟津县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1548, '河南省洛阳市新安县', '新安县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1549, '河南省洛阳市栾川县', '栾川县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1550, '河南省洛阳市嵩县', '嵩县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1551, '河南省洛阳市汝阳县', '汝阳县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1552, '河南省洛阳市宜阳县', '宜阳县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1553, '河南省洛阳市洛宁县', '洛宁县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1554, '河南省洛阳市伊川县', '伊川县', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1555, '河南省洛阳市偃师市', '偃师市', ',1515,1540,', 1540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1556, '河南省平顶山市', '平顶山市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1557, '河南省平顶山市新华区', '新华区', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1558, '河南省平顶山市卫东区', '卫东区', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1559, '河南省平顶山市石龙区', '石龙区', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1560, '河南省平顶山市湛河区', '湛河区', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1561, '河南省平顶山市宝丰县', '宝丰县', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1562, '河南省平顶山市叶县', '叶县', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1563, '河南省平顶山市鲁山县', '鲁山县', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1564, '河南省平顶山市郏县', '郏县', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1565, '河南省平顶山市舞钢市', '舞钢市', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1566, '河南省平顶山市汝州市', '汝州市', ',1515,1556,', 1556, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1567, '河南省安阳市', '安阳市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1568, '河南省安阳市文峰区', '文峰区', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1569, '河南省安阳市北关区', '北关区', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1570, '河南省安阳市殷都区', '殷都区', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1571, '河南省安阳市龙安区', '龙安区', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1572, '河南省安阳市安阳县', '安阳县', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1573, '河南省安阳市汤阴县', '汤阴县', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1574, '河南省安阳市滑县', '滑县', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1575, '河南省安阳市内黄县', '内黄县', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1576, '河南省安阳市林州市', '林州市', ',1515,1567,', 1567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1577, '河南省鹤壁市', '鹤壁市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1578, '河南省鹤壁市鹤山区', '鹤山区', ',1515,1577,', 1577, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1579, '河南省鹤壁市山城区', '山城区', ',1515,1577,', 1577, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1580, '河南省鹤壁市淇滨区', '淇滨区', ',1515,1577,', 1577, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1581, '河南省鹤壁市浚县', '浚县', ',1515,1577,', 1577, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1582, '河南省鹤壁市淇县', '淇县', ',1515,1577,', 1577, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1583, '河南省新乡市', '新乡市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1584, '河南省新乡市红旗区', '红旗区', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1585, '河南省新乡市卫滨区', '卫滨区', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1586, '河南省新乡市凤泉区', '凤泉区', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1587, '河南省新乡市牧野区', '牧野区', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1588, '河南省新乡市新乡县', '新乡县', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1589, '河南省新乡市获嘉县', '获嘉县', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1590, '河南省新乡市原阳县', '原阳县', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1591, '河南省新乡市延津县', '延津县', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1592, '河南省新乡市封丘县', '封丘县', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1593, '河南省新乡市长垣县', '长垣县', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1594, '河南省新乡市卫辉市', '卫辉市', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1595, '河南省新乡市辉县市', '辉县市', ',1515,1583,', 1583, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1596, '河南省焦作市', '焦作市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1597, '河南省焦作市解放区', '解放区', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1598, '河南省焦作市中站区', '中站区', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1599, '河南省焦作市马村区', '马村区', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1600, '河南省焦作市山阳区', '山阳区', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1601, '河南省焦作市修武县', '修武县', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1602, '河南省焦作市博爱县', '博爱县', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1603, '河南省焦作市武陟县', '武陟县', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1604, '河南省焦作市温县', '温县', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1605, '河南省焦作市沁阳市', '沁阳市', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1606, '河南省焦作市孟州市', '孟州市', ',1515,1596,', 1596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1607, '河南省濮阳市', '濮阳市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1608, '河南省濮阳市华龙区', '华龙区', ',1515,1607,', 1607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1609, '河南省濮阳市清丰县', '清丰县', ',1515,1607,', 1607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1610, '河南省濮阳市南乐县', '南乐县', ',1515,1607,', 1607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1611, '河南省濮阳市范县', '范县', ',1515,1607,', 1607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1612, '河南省濮阳市台前县', '台前县', ',1515,1607,', 1607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1613, '河南省濮阳市濮阳县', '濮阳县', ',1515,1607,', 1607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1614, '河南省许昌市', '许昌市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1615, '河南省许昌市魏都区', '魏都区', ',1515,1614,', 1614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1616, '河南省许昌市许昌县', '许昌县', ',1515,1614,', 1614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1617, '河南省许昌市鄢陵县', '鄢陵县', ',1515,1614,', 1614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1618, '河南省许昌市襄城县', '襄城县', ',1515,1614,', 1614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1619, '河南省许昌市禹州市', '禹州市', ',1515,1614,', 1614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1620, '河南省许昌市长葛市', '长葛市', ',1515,1614,', 1614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1621, '河南省漯河市', '漯河市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1622, '河南省漯河市源汇区', '源汇区', ',1515,1621,', 1621, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1623, '河南省漯河市郾城区', '郾城区', ',1515,1621,', 1621, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1624, '河南省漯河市召陵区', '召陵区', ',1515,1621,', 1621, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1625, '河南省漯河市舞阳县', '舞阳县', ',1515,1621,', 1621, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1626, '河南省漯河市临颍县', '临颍县', ',1515,1621,', 1621, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1627, '河南省三门峡市', '三门峡市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1628, '河南省三门峡市湖滨区', '湖滨区', ',1515,1627,', 1627, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1629, '河南省三门峡市渑池县', '渑池县', ',1515,1627,', 1627, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1630, '河南省三门峡市陕县', '陕县', ',1515,1627,', 1627, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1631, '河南省三门峡市卢氏县', '卢氏县', ',1515,1627,', 1627, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1632, '河南省三门峡市义马市', '义马市', ',1515,1627,', 1627, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1633, '河南省三门峡市灵宝市', '灵宝市', ',1515,1627,', 1627, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1634, '河南省南阳市', '南阳市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1635, '河南省南阳市宛城区', '宛城区', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1636, '河南省南阳市卧龙区', '卧龙区', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1637, '河南省南阳市南召县', '南召县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1638, '河南省南阳市方城县', '方城县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1639, '河南省南阳市西峡县', '西峡县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1640, '河南省南阳市镇平县', '镇平县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1641, '河南省南阳市内乡县', '内乡县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1642, '河南省南阳市淅川县', '淅川县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1643, '河南省南阳市社旗县', '社旗县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1644, '河南省南阳市唐河县', '唐河县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1645, '河南省南阳市新野县', '新野县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1646, '河南省南阳市桐柏县', '桐柏县', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1647, '河南省南阳市邓州市', '邓州市', ',1515,1634,', 1634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1648, '河南省商丘市', '商丘市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1649, '河南省商丘市梁园区', '梁园区', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1650, '河南省商丘市睢阳区', '睢阳区', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1651, '河南省商丘市民权县', '民权县', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1652, '河南省商丘市睢县', '睢县', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1653, '河南省商丘市宁陵县', '宁陵县', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1654, '河南省商丘市柘城县', '柘城县', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1655, '河南省商丘市虞城县', '虞城县', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1656, '河南省商丘市夏邑县', '夏邑县', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1657, '河南省商丘市永城市', '永城市', ',1515,1648,', 1648, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1658, '河南省信阳市', '信阳市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1659, '河南省信阳市浉河区', '浉河区', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1660, '河南省信阳市平桥区', '平桥区', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1661, '河南省信阳市罗山县', '罗山县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1662, '河南省信阳市光山县', '光山县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1663, '河南省信阳市新县', '新县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1664, '河南省信阳市商城县', '商城县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1665, '河南省信阳市固始县', '固始县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1666, '河南省信阳市潢川县', '潢川县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1667, '河南省信阳市淮滨县', '淮滨县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1668, '河南省信阳市息县', '息县', ',1515,1658,', 1658, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1669, '河南省周口市', '周口市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1670, '河南省周口市川汇区', '川汇区', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1671, '河南省周口市扶沟县', '扶沟县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1672, '河南省周口市西华县', '西华县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1673, '河南省周口市商水县', '商水县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1674, '河南省周口市沈丘县', '沈丘县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1675, '河南省周口市郸城县', '郸城县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1676, '河南省周口市淮阳县', '淮阳县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1677, '河南省周口市太康县', '太康县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1678, '河南省周口市鹿邑县', '鹿邑县', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1679, '河南省周口市项城市', '项城市', ',1515,1669,', 1669, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1680, '河南省驻马店市', '驻马店市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1681, '河南省驻马店市驿城区', '驿城区', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1682, '河南省驻马店市西平县', '西平县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1683, '河南省驻马店市上蔡县', '上蔡县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1684, '河南省驻马店市平舆县', '平舆县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1685, '河南省驻马店市正阳县', '正阳县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1686, '河南省驻马店市确山县', '确山县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1687, '河南省驻马店市泌阳县', '泌阳县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1688, '河南省驻马店市汝南县', '汝南县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1689, '河南省驻马店市遂平县', '遂平县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1690, '河南省驻马店市新蔡县', '新蔡县', ',1515,1680,', 1680, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1691, '河南省济源市', '济源市', ',1515,', 1515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1692, '湖北省', '湖北省', ',', NULL, 16, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1693, '湖北省武汉市', '武汉市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1694, '湖北省武汉市江岸区', '江岸区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1695, '湖北省武汉市江汉区', '江汉区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1696, '湖北省武汉市硚口区', '硚口区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1697, '湖北省武汉市汉阳区', '汉阳区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1698, '湖北省武汉市武昌区', '武昌区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1699, '湖北省武汉市青山区', '青山区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1700, '湖北省武汉市洪山区', '洪山区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1701, '湖北省武汉市东西湖区', '东西湖区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1702, '湖北省武汉市汉南区', '汉南区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1703, '湖北省武汉市蔡甸区', '蔡甸区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1704, '湖北省武汉市江夏区', '江夏区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1705, '湖北省武汉市黄陂区', '黄陂区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1706, '湖北省武汉市新洲区', '新洲区', ',1692,1693,', 1693, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1707, '湖北省黄石市', '黄石市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1708, '湖北省黄石市黄石港区', '黄石港区', ',1692,1707,', 1707, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1709, '湖北省黄石市西塞山区', '西塞山区', ',1692,1707,', 1707, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1710, '湖北省黄石市下陆区', '下陆区', ',1692,1707,', 1707, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1711, '湖北省黄石市铁山区', '铁山区', ',1692,1707,', 1707, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1712, '湖北省黄石市阳新县', '阳新县', ',1692,1707,', 1707, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1713, '湖北省黄石市大冶市', '大冶市', ',1692,1707,', 1707, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1714, '湖北省十堰市', '十堰市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1715, '湖北省十堰市茅箭区', '茅箭区', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1716, '湖北省十堰市张湾区', '张湾区', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1717, '湖北省十堰市郧县', '郧县', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1718, '湖北省十堰市郧西县', '郧西县', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1719, '湖北省十堰市竹山县', '竹山县', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1720, '湖北省十堰市竹溪县', '竹溪县', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1721, '湖北省十堰市房县', '房县', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1722, '湖北省十堰市丹江口市', '丹江口市', ',1692,1714,', 1714, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1723, '湖北省宜昌市', '宜昌市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1724, '湖北省宜昌市西陵区', '西陵区', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1725, '湖北省宜昌市伍家岗区', '伍家岗区', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1726, '湖北省宜昌市点军区', '点军区', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1727, '湖北省宜昌市猇亭区', '猇亭区', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1728, '湖北省宜昌市夷陵区', '夷陵区', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1729, '湖北省宜昌市远安县', '远安县', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1730, '湖北省宜昌市兴山县', '兴山县', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1731, '湖北省宜昌市秭归县', '秭归县', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1732, '湖北省宜昌市长阳土家族自治县', '长阳土家族自治县', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1733, '湖北省宜昌市五峰土家族自治县', '五峰土家族自治县', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1734, '湖北省宜昌市宜都市', '宜都市', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1735, '湖北省宜昌市当阳市', '当阳市', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1736, '湖北省宜昌市枝江市', '枝江市', ',1692,1723,', 1723, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1737, '湖北省襄阳市', '襄阳市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1738, '湖北省襄阳市襄城区', '襄城区', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1739, '湖北省襄阳市樊城区', '樊城区', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1740, '湖北省襄阳市襄州区', '襄州区', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1741, '湖北省襄阳市南漳县', '南漳县', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1742, '湖北省襄阳市谷城县', '谷城县', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1743, '湖北省襄阳市保康县', '保康县', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1744, '湖北省襄阳市老河口市', '老河口市', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1745, '湖北省襄阳市枣阳市', '枣阳市', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1746, '湖北省襄阳市宜城市', '宜城市', ',1692,1737,', 1737, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1747, '湖北省鄂州市', '鄂州市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1748, '湖北省鄂州市梁子湖区', '梁子湖区', ',1692,1747,', 1747, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1749, '湖北省鄂州市华容区', '华容区', ',1692,1747,', 1747, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1750, '湖北省鄂州市鄂城区', '鄂城区', ',1692,1747,', 1747, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1751, '湖北省荆门市', '荆门市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1752, '湖北省荆门市东宝区', '东宝区', ',1692,1751,', 1751, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1753, '湖北省荆门市掇刀区', '掇刀区', ',1692,1751,', 1751, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1754, '湖北省荆门市京山县', '京山县', ',1692,1751,', 1751, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1755, '湖北省荆门市沙洋县', '沙洋县', ',1692,1751,', 1751, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1756, '湖北省荆门市钟祥市', '钟祥市', ',1692,1751,', 1751, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1757, '湖北省孝感市', '孝感市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1758, '湖北省孝感市孝南区', '孝南区', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1759, '湖北省孝感市孝昌县', '孝昌县', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1760, '湖北省孝感市大悟县', '大悟县', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1761, '湖北省孝感市云梦县', '云梦县', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1762, '湖北省孝感市应城市', '应城市', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1763, '湖北省孝感市安陆市', '安陆市', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1764, '湖北省孝感市汉川市', '汉川市', ',1692,1757,', 1757, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1765, '湖北省荆州市', '荆州市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1766, '湖北省荆州市沙市区', '沙市区', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1767, '湖北省荆州市荆州区', '荆州区', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1768, '湖北省荆州市公安县', '公安县', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1769, '湖北省荆州市监利县', '监利县', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1770, '湖北省荆州市江陵县', '江陵县', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1771, '湖北省荆州市石首市', '石首市', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1772, '湖北省荆州市洪湖市', '洪湖市', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1773, '湖北省荆州市松滋市', '松滋市', ',1692,1765,', 1765, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1774, '湖北省黄冈市', '黄冈市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1775, '湖北省黄冈市黄州区', '黄州区', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1776, '湖北省黄冈市团风县', '团风县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1777, '湖北省黄冈市红安县', '红安县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1778, '湖北省黄冈市罗田县', '罗田县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1779, '湖北省黄冈市英山县', '英山县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1780, '湖北省黄冈市浠水县', '浠水县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1781, '湖北省黄冈市蕲春县', '蕲春县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1782, '湖北省黄冈市黄梅县', '黄梅县', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1783, '湖北省黄冈市麻城市', '麻城市', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1784, '湖北省黄冈市武穴市', '武穴市', ',1692,1774,', 1774, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1785, '湖北省咸宁市', '咸宁市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1786, '湖北省咸宁市咸安区', '咸安区', ',1692,1785,', 1785, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1787, '湖北省咸宁市嘉鱼县', '嘉鱼县', ',1692,1785,', 1785, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1788, '湖北省咸宁市通城县', '通城县', ',1692,1785,', 1785, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1789, '湖北省咸宁市崇阳县', '崇阳县', ',1692,1785,', 1785, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1790, '湖北省咸宁市通山县', '通山县', ',1692,1785,', 1785, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1791, '湖北省咸宁市赤壁市', '赤壁市', ',1692,1785,', 1785, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1792, '湖北省随州市', '随州市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1793, '湖北省随州市曾都区', '曾都区', ',1692,1792,', 1792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1794, '湖北省随州市随县', '随县', ',1692,1792,', 1792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1795, '湖北省随州市广水市', '广水市', ',1692,1792,', 1792, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1796, '湖北省恩施土家族苗族自治州', '恩施土家族苗族自治州', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1797, '湖北省恩施土家族苗族自治州恩施市', '恩施市', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1798, '湖北省恩施土家族苗族自治州利川市', '利川市', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1799, '湖北省恩施土家族苗族自治州建始县', '建始县', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1800, '湖北省恩施土家族苗族自治州巴东县', '巴东县', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1801, '湖北省恩施土家族苗族自治州宣恩县', '宣恩县', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1802, '湖北省恩施土家族苗族自治州咸丰县', '咸丰县', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1803, '湖北省恩施土家族苗族自治州来凤县', '来凤县', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1804, '湖北省恩施土家族苗族自治州鹤峰县', '鹤峰县', ',1692,1796,', 1796, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1805, '湖北省仙桃市', '仙桃市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1806, '湖北省潜江市', '潜江市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1807, '湖北省天门市', '天门市', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1808, '湖北省神农架林区', '神农架林区', ',1692,', 1692, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1809, '湖南省', '湖南省', ',', NULL, 17, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1810, '湖南省长沙市', '长沙市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1811, '湖南省长沙市芙蓉区', '芙蓉区', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1812, '湖南省长沙市天心区', '天心区', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1813, '湖南省长沙市岳麓区', '岳麓区', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1814, '湖南省长沙市开福区', '开福区', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1815, '湖南省长沙市雨花区', '雨花区', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1816, '湖南省长沙市望城区', '望城区', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1817, '湖南省长沙市长沙县', '长沙县', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1818, '湖南省长沙市宁乡县', '宁乡县', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1819, '湖南省长沙市浏阳市', '浏阳市', ',1809,1810,', 1810, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1820, '湖南省株洲市', '株洲市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1821, '湖南省株洲市荷塘区', '荷塘区', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1822, '湖南省株洲市芦淞区', '芦淞区', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1823, '湖南省株洲市石峰区', '石峰区', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1824, '湖南省株洲市天元区', '天元区', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1825, '湖南省株洲市株洲县', '株洲县', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1826, '湖南省株洲市攸县', '攸县', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1827, '湖南省株洲市茶陵县', '茶陵县', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1828, '湖南省株洲市炎陵县', '炎陵县', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1829, '湖南省株洲市醴陵市', '醴陵市', ',1809,1820,', 1820, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1830, '湖南省湘潭市', '湘潭市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1831, '湖南省湘潭市雨湖区', '雨湖区', ',1809,1830,', 1830, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1832, '湖南省湘潭市岳塘区', '岳塘区', ',1809,1830,', 1830, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1833, '湖南省湘潭市湘潭县', '湘潭县', ',1809,1830,', 1830, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1834, '湖南省湘潭市湘乡市', '湘乡市', ',1809,1830,', 1830, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1835, '湖南省湘潭市韶山市', '韶山市', ',1809,1830,', 1830, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1836, '湖南省衡阳市', '衡阳市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1837, '湖南省衡阳市珠晖区', '珠晖区', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1838, '湖南省衡阳市雁峰区', '雁峰区', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1839, '湖南省衡阳市石鼓区', '石鼓区', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1840, '湖南省衡阳市蒸湘区', '蒸湘区', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1841, '湖南省衡阳市南岳区', '南岳区', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1842, '湖南省衡阳市衡阳县', '衡阳县', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1843, '湖南省衡阳市衡南县', '衡南县', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1844, '湖南省衡阳市衡山县', '衡山县', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1845, '湖南省衡阳市衡东县', '衡东县', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1846, '湖南省衡阳市祁东县', '祁东县', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1847, '湖南省衡阳市耒阳市', '耒阳市', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1848, '湖南省衡阳市常宁市', '常宁市', ',1809,1836,', 1836, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1849, '湖南省邵阳市', '邵阳市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1850, '湖南省邵阳市双清区', '双清区', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1851, '湖南省邵阳市大祥区', '大祥区', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1852, '湖南省邵阳市北塔区', '北塔区', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1853, '湖南省邵阳市邵东县', '邵东县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1854, '湖南省邵阳市新邵县', '新邵县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1855, '湖南省邵阳市邵阳县', '邵阳县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1856, '湖南省邵阳市隆回县', '隆回县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1857, '湖南省邵阳市洞口县', '洞口县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1858, '湖南省邵阳市绥宁县', '绥宁县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1859, '湖南省邵阳市新宁县', '新宁县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1860, '湖南省邵阳市城步苗族自治县', '城步苗族自治县', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1861, '湖南省邵阳市武冈市', '武冈市', ',1809,1849,', 1849, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1862, '湖南省岳阳市', '岳阳市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1863, '湖南省岳阳市岳阳楼区', '岳阳楼区', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1864, '湖南省岳阳市云溪区', '云溪区', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1865, '湖南省岳阳市君山区', '君山区', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1866, '湖南省岳阳市岳阳县', '岳阳县', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1867, '湖南省岳阳市华容县', '华容县', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1868, '湖南省岳阳市湘阴县', '湘阴县', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1869, '湖南省岳阳市平江县', '平江县', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1870, '湖南省岳阳市汨罗市', '汨罗市', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1871, '湖南省岳阳市临湘市', '临湘市', ',1809,1862,', 1862, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1872, '湖南省常德市', '常德市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1873, '湖南省常德市武陵区', '武陵区', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1874, '湖南省常德市鼎城区', '鼎城区', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1875, '湖南省常德市安乡县', '安乡县', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1876, '湖南省常德市汉寿县', '汉寿县', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1877, '湖南省常德市澧县', '澧县', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1878, '湖南省常德市临澧县', '临澧县', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1879, '湖南省常德市桃源县', '桃源县', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1880, '湖南省常德市石门县', '石门县', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1881, '湖南省常德市津市市', '津市市', ',1809,1872,', 1872, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1882, '湖南省张家界市', '张家界市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1883, '湖南省张家界市永定区', '永定区', ',1809,1882,', 1882, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1884, '湖南省张家界市武陵源区', '武陵源区', ',1809,1882,', 1882, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1885, '湖南省张家界市慈利县', '慈利县', ',1809,1882,', 1882, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1886, '湖南省张家界市桑植县', '桑植县', ',1809,1882,', 1882, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1887, '湖南省益阳市', '益阳市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1888, '湖南省益阳市资阳区', '资阳区', ',1809,1887,', 1887, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1889, '湖南省益阳市赫山区', '赫山区', ',1809,1887,', 1887, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1890, '湖南省益阳市南县', '南县', ',1809,1887,', 1887, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1891, '湖南省益阳市桃江县', '桃江县', ',1809,1887,', 1887, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1892, '湖南省益阳市安化县', '安化县', ',1809,1887,', 1887, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1893, '湖南省益阳市沅江市', '沅江市', ',1809,1887,', 1887, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1894, '湖南省郴州市', '郴州市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1895, '湖南省郴州市北湖区', '北湖区', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1896, '湖南省郴州市苏仙区', '苏仙区', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1897, '湖南省郴州市桂阳县', '桂阳县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1898, '湖南省郴州市宜章县', '宜章县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1899, '湖南省郴州市永兴县', '永兴县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1900, '湖南省郴州市嘉禾县', '嘉禾县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1901, '湖南省郴州市临武县', '临武县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1902, '湖南省郴州市汝城县', '汝城县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1903, '湖南省郴州市桂东县', '桂东县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1904, '湖南省郴州市安仁县', '安仁县', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1905, '湖南省郴州市资兴市', '资兴市', ',1809,1894,', 1894, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1906, '湖南省永州市', '永州市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1907, '湖南省永州市零陵区', '零陵区', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1908, '湖南省永州市冷水滩区', '冷水滩区', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1909, '湖南省永州市祁阳县', '祁阳县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1910, '湖南省永州市东安县', '东安县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1911, '湖南省永州市双牌县', '双牌县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1912, '湖南省永州市道县', '道县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1913, '湖南省永州市江永县', '江永县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1914, '湖南省永州市宁远县', '宁远县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1915, '湖南省永州市蓝山县', '蓝山县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1916, '湖南省永州市新田县', '新田县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1917, '湖南省永州市江华瑶族自治县', '江华瑶族自治县', ',1809,1906,', 1906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1918, '湖南省怀化市', '怀化市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1919, '湖南省怀化市鹤城区', '鹤城区', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1920, '湖南省怀化市中方县', '中方县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1921, '湖南省怀化市沅陵县', '沅陵县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1922, '湖南省怀化市辰溪县', '辰溪县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1923, '湖南省怀化市溆浦县', '溆浦县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1924, '湖南省怀化市会同县', '会同县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1925, '湖南省怀化市麻阳苗族自治县', '麻阳苗族自治县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1926, '湖南省怀化市新晃侗族自治县', '新晃侗族自治县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1927, '湖南省怀化市芷江侗族自治县', '芷江侗族自治县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1928, '湖南省怀化市靖州苗族侗族自治县', '靖州苗族侗族自治县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1929, '湖南省怀化市通道侗族自治县', '通道侗族自治县', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1930, '湖南省怀化市洪江市', '洪江市', ',1809,1918,', 1918, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1931, '湖南省娄底市', '娄底市', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1932, '湖南省娄底市娄星区', '娄星区', ',1809,1931,', 1931, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1933, '湖南省娄底市双峰县', '双峰县', ',1809,1931,', 1931, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1934, '湖南省娄底市新化县', '新化县', ',1809,1931,', 1931, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1935, '湖南省娄底市冷水江市', '冷水江市', ',1809,1931,', 1931, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1936, '湖南省娄底市涟源市', '涟源市', ',1809,1931,', 1931, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1937, '湖南省湘西土家族苗族自治州', '湘西土家族苗族自治州', ',1809,', 1809, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1938, '湖南省湘西土家族苗族自治州吉首市', '吉首市', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1939, '湖南省湘西土家族苗族自治州泸溪县', '泸溪县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1940, '湖南省湘西土家族苗族自治州凤凰县', '凤凰县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1941, '湖南省湘西土家族苗族自治州花垣县', '花垣县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1942, '湖南省湘西土家族苗族自治州保靖县', '保靖县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1943, '湖南省湘西土家族苗族自治州古丈县', '古丈县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1944, '湖南省湘西土家族苗族自治州永顺县', '永顺县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1945, '湖南省湘西土家族苗族自治州龙山县', '龙山县', ',1809,1937,', 1937, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1946, '广东省', '广东省', ',', NULL, 18, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1947, '广东省广州市', '广州市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1948, '广东省广州市荔湾区', '荔湾区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1949, '广东省广州市越秀区', '越秀区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1950, '广东省广州市海珠区', '海珠区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1951, '广东省广州市天河区', '天河区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1952, '广东省广州市白云区', '白云区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1953, '广东省广州市黄埔区', '黄埔区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1954, '广东省广州市番禺区', '番禺区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1955, '广东省广州市花都区', '花都区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1956, '广东省广州市南沙区', '南沙区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1957, '广东省广州市萝岗区', '萝岗区', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1958, '广东省广州市增城市', '增城市', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1959, '广东省广州市从化市', '从化市', ',1946,1947,', 1947, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1960, '广东省韶关市', '韶关市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1961, '广东省韶关市武江区', '武江区', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1962, '广东省韶关市浈江区', '浈江区', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1963, '广东省韶关市曲江区', '曲江区', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1964, '广东省韶关市始兴县', '始兴县', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1965, '广东省韶关市仁化县', '仁化县', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1966, '广东省韶关市翁源县', '翁源县', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1967, '广东省韶关市乳源瑶族自治县', '乳源瑶族自治县', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1968, '广东省韶关市新丰县', '新丰县', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1969, '广东省韶关市乐昌市', '乐昌市', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1970, '广东省韶关市南雄市', '南雄市', ',1946,1960,', 1960, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1971, '广东省深圳市', '深圳市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1972, '广东省深圳市罗湖区', '罗湖区', ',1946,1971,', 1971, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1973, '广东省深圳市福田区', '福田区', ',1946,1971,', 1971, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1974, '广东省深圳市南山区', '南山区', ',1946,1971,', 1971, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1975, '广东省深圳市宝安区', '宝安区', ',1946,1971,', 1971, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1976, '广东省深圳市龙岗区', '龙岗区', ',1946,1971,', 1971, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1977, '广东省深圳市盐田区', '盐田区', ',1946,1971,', 1971, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1978, '广东省珠海市', '珠海市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1979, '广东省珠海市香洲区', '香洲区', ',1946,1978,', 1978, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1980, '广东省珠海市斗门区', '斗门区', ',1946,1978,', 1978, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1981, '广东省珠海市金湾区', '金湾区', ',1946,1978,', 1978, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1982, '广东省汕头市', '汕头市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1983, '广东省汕头市龙湖区', '龙湖区', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1984, '广东省汕头市金平区', '金平区', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1985, '广东省汕头市濠江区', '濠江区', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1986, '广东省汕头市潮阳区', '潮阳区', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1987, '广东省汕头市潮南区', '潮南区', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1988, '广东省汕头市澄海区', '澄海区', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1989, '广东省汕头市南澳县', '南澳县', ',1946,1982,', 1982, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1990, '广东省佛山市', '佛山市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1991, '广东省佛山市禅城区', '禅城区', ',1946,1990,', 1990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1992, '广东省佛山市南海区', '南海区', ',1946,1990,', 1990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1993, '广东省佛山市顺德区', '顺德区', ',1946,1990,', 1990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1994, '广东省佛山市三水区', '三水区', ',1946,1990,', 1990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1995, '广东省佛山市高明区', '高明区', ',1946,1990,', 1990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1996, '广东省江门市', '江门市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1997, '广东省江门市蓬江区', '蓬江区', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1998, '广东省江门市江海区', '江海区', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (1999, '广东省江门市新会区', '新会区', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2000, '广东省江门市台山市', '台山市', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2001, '广东省江门市开平市', '开平市', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2002, '广东省江门市鹤山市', '鹤山市', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2003, '广东省江门市恩平市', '恩平市', ',1946,1996,', 1996, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2004, '广东省湛江市', '湛江市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2005, '广东省湛江市赤坎区', '赤坎区', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2006, '广东省湛江市霞山区', '霞山区', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2007, '广东省湛江市坡头区', '坡头区', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2008, '广东省湛江市麻章区', '麻章区', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2009, '广东省湛江市遂溪县', '遂溪县', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2010, '广东省湛江市徐闻县', '徐闻县', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2011, '广东省湛江市廉江市', '廉江市', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2012, '广东省湛江市雷州市', '雷州市', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2013, '广东省湛江市吴川市', '吴川市', ',1946,2004,', 2004, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2014, '广东省茂名市', '茂名市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2015, '广东省茂名市茂南区', '茂南区', ',1946,2014,', 2014, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2016, '广东省茂名市茂港区', '茂港区', ',1946,2014,', 2014, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2017, '广东省茂名市电白县', '电白县', ',1946,2014,', 2014, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2018, '广东省茂名市高州市', '高州市', ',1946,2014,', 2014, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2019, '广东省茂名市化州市', '化州市', ',1946,2014,', 2014, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2020, '广东省茂名市信宜市', '信宜市', ',1946,2014,', 2014, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2021, '广东省肇庆市', '肇庆市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2022, '广东省肇庆市端州区', '端州区', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2023, '广东省肇庆市鼎湖区', '鼎湖区', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2024, '广东省肇庆市广宁县', '广宁县', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2025, '广东省肇庆市怀集县', '怀集县', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2026, '广东省肇庆市封开县', '封开县', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2027, '广东省肇庆市德庆县', '德庆县', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2028, '广东省肇庆市高要市', '高要市', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2029, '广东省肇庆市四会市', '四会市', ',1946,2021,', 2021, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2030, '广东省惠州市', '惠州市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2031, '广东省惠州市惠城区', '惠城区', ',1946,2030,', 2030, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2032, '广东省惠州市惠阳区', '惠阳区', ',1946,2030,', 2030, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2033, '广东省惠州市博罗县', '博罗县', ',1946,2030,', 2030, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2034, '广东省惠州市惠东县', '惠东县', ',1946,2030,', 2030, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2035, '广东省惠州市龙门县', '龙门县', ',1946,2030,', 2030, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2036, '广东省梅州市', '梅州市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2037, '广东省梅州市梅江区', '梅江区', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2038, '广东省梅州市梅县', '梅县', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2039, '广东省梅州市大埔县', '大埔县', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2040, '广东省梅州市丰顺县', '丰顺县', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2041, '广东省梅州市五华县', '五华县', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2042, '广东省梅州市平远县', '平远县', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2043, '广东省梅州市蕉岭县', '蕉岭县', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2044, '广东省梅州市兴宁市', '兴宁市', ',1946,2036,', 2036, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2045, '广东省汕尾市', '汕尾市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2046, '广东省汕尾市城区', '城区', ',1946,2045,', 2045, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2047, '广东省汕尾市海丰县', '海丰县', ',1946,2045,', 2045, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2048, '广东省汕尾市陆河县', '陆河县', ',1946,2045,', 2045, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2049, '广东省汕尾市陆丰市', '陆丰市', ',1946,2045,', 2045, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2050, '广东省河源市', '河源市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2051, '广东省河源市源城区', '源城区', ',1946,2050,', 2050, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2052, '广东省河源市紫金县', '紫金县', ',1946,2050,', 2050, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2053, '广东省河源市龙川县', '龙川县', ',1946,2050,', 2050, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2054, '广东省河源市连平县', '连平县', ',1946,2050,', 2050, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2055, '广东省河源市和平县', '和平县', ',1946,2050,', 2050, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2056, '广东省河源市东源县', '东源县', ',1946,2050,', 2050, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2057, '广东省阳江市', '阳江市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2058, '广东省阳江市江城区', '江城区', ',1946,2057,', 2057, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2059, '广东省阳江市阳西县', '阳西县', ',1946,2057,', 2057, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2060, '广东省阳江市阳东县', '阳东县', ',1946,2057,', 2057, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2061, '广东省阳江市阳春市', '阳春市', ',1946,2057,', 2057, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2062, '广东省清远市', '清远市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2063, '广东省清远市清城区', '清城区', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2064, '广东省清远市佛冈县', '佛冈县', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2065, '广东省清远市阳山县', '阳山县', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2066, '广东省清远市连山壮族瑶族自治县', '连山壮族瑶族自治县', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2067, '广东省清远市连南瑶族自治县', '连南瑶族自治县', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2068, '广东省清远市清新县', '清新县', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2069, '广东省清远市英德市', '英德市', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2070, '广东省清远市连州市', '连州市', ',1946,2062,', 2062, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2071, '广东省东莞市', '东莞市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2072, '广东省中山市', '中山市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2073, '广东省潮州市', '潮州市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2074, '广东省潮州市湘桥区', '湘桥区', ',1946,2073,', 2073, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2075, '广东省潮州市潮安县', '潮安县', ',1946,2073,', 2073, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2076, '广东省潮州市饶平县', '饶平县', ',1946,2073,', 2073, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2077, '广东省揭阳市', '揭阳市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2078, '广东省揭阳市榕城区', '榕城区', ',1946,2077,', 2077, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2079, '广东省揭阳市揭东县', '揭东县', ',1946,2077,', 2077, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2080, '广东省揭阳市揭西县', '揭西县', ',1946,2077,', 2077, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2081, '广东省揭阳市惠来县', '惠来县', ',1946,2077,', 2077, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2082, '广东省揭阳市普宁市', '普宁市', ',1946,2077,', 2077, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2083, '广东省云浮市', '云浮市', ',1946,', 1946, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2084, '广东省云浮市云城区', '云城区', ',1946,2083,', 2083, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2085, '广东省云浮市新兴县', '新兴县', ',1946,2083,', 2083, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2086, '广东省云浮市郁南县', '郁南县', ',1946,2083,', 2083, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2087, '广东省云浮市云安县', '云安县', ',1946,2083,', 2083, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2088, '广东省云浮市罗定市', '罗定市', ',1946,2083,', 2083, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2089, '广西壮族自治区', '广西壮族自治区', ',', NULL, 19, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2090, '广西壮族自治区南宁市', '南宁市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2091, '广西壮族自治区南宁市兴宁区', '兴宁区', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2092, '广西壮族自治区南宁市青秀区', '青秀区', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2093, '广西壮族自治区南宁市江南区', '江南区', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2094, '广西壮族自治区南宁市西乡塘区', '西乡塘区', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2095, '广西壮族自治区南宁市良庆区', '良庆区', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2096, '广西壮族自治区南宁市邕宁区', '邕宁区', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2097, '广西壮族自治区南宁市武鸣县', '武鸣县', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2098, '广西壮族自治区南宁市隆安县', '隆安县', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2099, '广西壮族自治区南宁市马山县', '马山县', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2100, '广西壮族自治区南宁市上林县', '上林县', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2101, '广西壮族自治区南宁市宾阳县', '宾阳县', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2102, '广西壮族自治区南宁市横县', '横县', ',2089,2090,', 2090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2103, '广西壮族自治区柳州市', '柳州市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2104, '广西壮族自治区柳州市城中区', '城中区', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2105, '广西壮族自治区柳州市鱼峰区', '鱼峰区', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2106, '广西壮族自治区柳州市柳南区', '柳南区', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2107, '广西壮族自治区柳州市柳北区', '柳北区', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2108, '广西壮族自治区柳州市柳江县', '柳江县', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2109, '广西壮族自治区柳州市柳城县', '柳城县', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2110, '广西壮族自治区柳州市鹿寨县', '鹿寨县', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2111, '广西壮族自治区柳州市融安县', '融安县', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2112, '广西壮族自治区柳州市融水苗族自治县', '融水苗族自治县', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2113, '广西壮族自治区柳州市三江侗族自治县', '三江侗族自治县', ',2089,2103,', 2103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2114, '广西壮族自治区桂林市', '桂林市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2115, '广西壮族自治区桂林市秀峰区', '秀峰区', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2116, '广西壮族自治区桂林市叠彩区', '叠彩区', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2117, '广西壮族自治区桂林市象山区', '象山区', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2118, '广西壮族自治区桂林市七星区', '七星区', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2119, '广西壮族自治区桂林市雁山区', '雁山区', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2120, '广西壮族自治区桂林市阳朔县', '阳朔县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2121, '广西壮族自治区桂林市临桂县', '临桂县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2122, '广西壮族自治区桂林市灵川县', '灵川县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2123, '广西壮族自治区桂林市全州县', '全州县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2124, '广西壮族自治区桂林市兴安县', '兴安县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2125, '广西壮族自治区桂林市永福县', '永福县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2126, '广西壮族自治区桂林市灌阳县', '灌阳县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2127, '广西壮族自治区桂林市龙胜各族自治县', '龙胜各族自治县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2128, '广西壮族自治区桂林市资源县', '资源县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2129, '广西壮族自治区桂林市平乐县', '平乐县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2130, '广西壮族自治区桂林市荔浦县', '荔浦县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2131, '广西壮族自治区桂林市恭城瑶族自治县', '恭城瑶族自治县', ',2089,2114,', 2114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2132, '广西壮族自治区梧州市', '梧州市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2133, '广西壮族自治区梧州市万秀区', '万秀区', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2134, '广西壮族自治区梧州市蝶山区', '蝶山区', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2135, '广西壮族自治区梧州市长洲区', '长洲区', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2136, '广西壮族自治区梧州市苍梧县', '苍梧县', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2137, '广西壮族自治区梧州市藤县', '藤县', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2138, '广西壮族自治区梧州市蒙山县', '蒙山县', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2139, '广西壮族自治区梧州市岑溪市', '岑溪市', ',2089,2132,', 2132, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2140, '广西壮族自治区北海市', '北海市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2141, '广西壮族自治区北海市海城区', '海城区', ',2089,2140,', 2140, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2142, '广西壮族自治区北海市银海区', '银海区', ',2089,2140,', 2140, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2143, '广西壮族自治区北海市铁山港区', '铁山港区', ',2089,2140,', 2140, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2144, '广西壮族自治区北海市合浦县', '合浦县', ',2089,2140,', 2140, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2145, '广西壮族自治区防城港市', '防城港市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2146, '广西壮族自治区防城港市港口区', '港口区', ',2089,2145,', 2145, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2147, '广西壮族自治区防城港市防城区', '防城区', ',2089,2145,', 2145, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2148, '广西壮族自治区防城港市上思县', '上思县', ',2089,2145,', 2145, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2149, '广西壮族自治区防城港市东兴市', '东兴市', ',2089,2145,', 2145, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2150, '广西壮族自治区钦州市', '钦州市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2151, '广西壮族自治区钦州市钦南区', '钦南区', ',2089,2150,', 2150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2152, '广西壮族自治区钦州市钦北区', '钦北区', ',2089,2150,', 2150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2153, '广西壮族自治区钦州市灵山县', '灵山县', ',2089,2150,', 2150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2154, '广西壮族自治区钦州市浦北县', '浦北县', ',2089,2150,', 2150, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2155, '广西壮族自治区贵港市', '贵港市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2156, '广西壮族自治区贵港市港北区', '港北区', ',2089,2155,', 2155, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2157, '广西壮族自治区贵港市港南区', '港南区', ',2089,2155,', 2155, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2158, '广西壮族自治区贵港市覃塘区', '覃塘区', ',2089,2155,', 2155, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2159, '广西壮族自治区贵港市平南县', '平南县', ',2089,2155,', 2155, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2160, '广西壮族自治区贵港市桂平市', '桂平市', ',2089,2155,', 2155, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2161, '广西壮族自治区玉林市', '玉林市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2162, '广西壮族自治区玉林市玉州区', '玉州区', ',2089,2161,', 2161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2163, '广西壮族自治区玉林市容县', '容县', ',2089,2161,', 2161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2164, '广西壮族自治区玉林市陆川县', '陆川县', ',2089,2161,', 2161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2165, '广西壮族自治区玉林市博白县', '博白县', ',2089,2161,', 2161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2166, '广西壮族自治区玉林市兴业县', '兴业县', ',2089,2161,', 2161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2167, '广西壮族自治区玉林市北流市', '北流市', ',2089,2161,', 2161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2168, '广西壮族自治区百色市', '百色市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2169, '广西壮族自治区百色市右江区', '右江区', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2170, '广西壮族自治区百色市田阳县', '田阳县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2171, '广西壮族自治区百色市田东县', '田东县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2172, '广西壮族自治区百色市平果县', '平果县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2173, '广西壮族自治区百色市德保县', '德保县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2174, '广西壮族自治区百色市靖西县', '靖西县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2175, '广西壮族自治区百色市那坡县', '那坡县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2176, '广西壮族自治区百色市凌云县', '凌云县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2177, '广西壮族自治区百色市乐业县', '乐业县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2178, '广西壮族自治区百色市田林县', '田林县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2179, '广西壮族自治区百色市西林县', '西林县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2180, '广西壮族自治区百色市隆林各族自治县', '隆林各族自治县', ',2089,2168,', 2168, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2181, '广西壮族自治区贺州市', '贺州市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2182, '广西壮族自治区贺州市八步区', '八步区', ',2089,2181,', 2181, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2183, '广西壮族自治区贺州市昭平县', '昭平县', ',2089,2181,', 2181, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2184, '广西壮族自治区贺州市钟山县', '钟山县', ',2089,2181,', 2181, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2185, '广西壮族自治区贺州市富川瑶族自治县', '富川瑶族自治县', ',2089,2181,', 2181, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2186, '广西壮族自治区河池市', '河池市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2187, '广西壮族自治区河池市金城江区', '金城江区', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2188, '广西壮族自治区河池市南丹县', '南丹县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2189, '广西壮族自治区河池市天峨县', '天峨县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2190, '广西壮族自治区河池市凤山县', '凤山县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2191, '广西壮族自治区河池市东兰县', '东兰县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2192, '广西壮族自治区河池市罗城仫佬族自治县', '罗城仫佬族自治县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2193, '广西壮族自治区河池市环江毛南族自治县', '环江毛南族自治县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2194, '广西壮族自治区河池市巴马瑶族自治县', '巴马瑶族自治县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2195, '广西壮族自治区河池市都安瑶族自治县', '都安瑶族自治县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2196, '广西壮族自治区河池市大化瑶族自治县', '大化瑶族自治县', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2197, '广西壮族自治区河池市宜州市', '宜州市', ',2089,2186,', 2186, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2198, '广西壮族自治区来宾市', '来宾市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2199, '广西壮族自治区来宾市兴宾区', '兴宾区', ',2089,2198,', 2198, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2200, '广西壮族自治区来宾市忻城县', '忻城县', ',2089,2198,', 2198, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2201, '广西壮族自治区来宾市象州县', '象州县', ',2089,2198,', 2198, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2202, '广西壮族自治区来宾市武宣县', '武宣县', ',2089,2198,', 2198, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2203, '广西壮族自治区来宾市金秀瑶族自治县', '金秀瑶族自治县', ',2089,2198,', 2198, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2204, '广西壮族自治区来宾市合山市', '合山市', ',2089,2198,', 2198, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2205, '广西壮族自治区崇左市', '崇左市', ',2089,', 2089, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2206, '广西壮族自治区崇左市江洲区', '江洲区', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2207, '广西壮族自治区崇左市扶绥县', '扶绥县', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2208, '广西壮族自治区崇左市宁明县', '宁明县', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2209, '广西壮族自治区崇左市龙州县', '龙州县', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2210, '广西壮族自治区崇左市大新县', '大新县', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2211, '广西壮族自治区崇左市天等县', '天等县', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2212, '广西壮族自治区崇左市凭祥市', '凭祥市', ',2089,2205,', 2205, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2213, '海南省', '海南省', ',', NULL, 20, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2214, '海南省海口市', '海口市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2215, '海南省海口市秀英区', '秀英区', ',2213,2214,', 2214, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2216, '海南省海口市龙华区', '龙华区', ',2213,2214,', 2214, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2217, '海南省海口市琼山区', '琼山区', ',2213,2214,', 2214, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2218, '海南省海口市美兰区', '美兰区', ',2213,2214,', 2214, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2219, '海南省三亚市', '三亚市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2220, '海南省三沙市', '三沙市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2221, '海南省三沙市西沙群岛', '西沙群岛', ',2213,2220,', 2220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2222, '海南省三沙市南沙群岛', '南沙群岛', ',2213,2220,', 2220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2223, '海南省三沙市中沙群岛的岛礁及其海域', '中沙群岛的岛礁及其海域', ',2213,2220,', 2220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2224, '海南省五指山市', '五指山市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2225, '海南省琼海市', '琼海市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2226, '海南省儋州市', '儋州市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2227, '海南省文昌市', '文昌市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2228, '海南省万宁市', '万宁市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2229, '海南省东方市', '东方市', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2230, '海南省定安县', '定安县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2231, '海南省屯昌县', '屯昌县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2232, '海南省澄迈县', '澄迈县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2233, '海南省临高县', '临高县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2234, '海南省白沙黎族自治县', '白沙黎族自治县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2235, '海南省昌江黎族自治县', '昌江黎族自治县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2236, '海南省乐东黎族自治县', '乐东黎族自治县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2237, '海南省陵水黎族自治县', '陵水黎族自治县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2238, '海南省保亭黎族苗族自治县', '保亭黎族苗族自治县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2239, '海南省琼中黎族苗族自治县', '琼中黎族苗族自治县', ',2213,', 2213, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2240, '重庆市', '重庆市', ',', NULL, 21, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2241, '重庆市万州区', '万州区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2242, '重庆市涪陵区', '涪陵区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2243, '重庆市渝中区', '渝中区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2244, '重庆市大渡口区', '大渡口区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2245, '重庆市江北区', '江北区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2246, '重庆市沙坪坝区', '沙坪坝区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2247, '重庆市九龙坡区', '九龙坡区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2248, '重庆市南岸区', '南岸区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2249, '重庆市北碚区', '北碚区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2250, '重庆市綦江区', '綦江区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2251, '重庆市大足区', '大足区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2252, '重庆市渝北区', '渝北区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2253, '重庆市巴南区', '巴南区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2254, '重庆市黔江区', '黔江区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2255, '重庆市长寿区', '长寿区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2256, '重庆市江津区', '江津区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2257, '重庆市合川区', '合川区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2258, '重庆市永川区', '永川区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2259, '重庆市南川区', '南川区', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2260, '重庆市潼南县', '潼南县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2261, '重庆市铜梁县', '铜梁县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2262, '重庆市荣昌县', '荣昌县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2263, '重庆市璧山县', '璧山县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2264, '重庆市梁平县', '梁平县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2265, '重庆市城口县', '城口县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2266, '重庆市丰都县', '丰都县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2267, '重庆市垫江县', '垫江县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2268, '重庆市武隆县', '武隆县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2269, '重庆市忠县', '忠县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2270, '重庆市开县', '开县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2271, '重庆市云阳县', '云阳县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2272, '重庆市奉节县', '奉节县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2273, '重庆市巫山县', '巫山县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2274, '重庆市巫溪县', '巫溪县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2275, '重庆市石柱土家族自治县', '石柱土家族自治县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2276, '重庆市秀山土家族苗族自治县', '秀山土家族苗族自治县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2277, '重庆市酉阳土家族苗族自治县', '酉阳土家族苗族自治县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2278, '重庆市彭水苗族土家族自治县', '彭水苗族土家族自治县', ',2240,', 2240, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2279, '四川省', '四川省', ',', NULL, 22, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2280, '四川省成都市', '成都市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2281, '四川省成都市锦江区', '锦江区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2282, '四川省成都市青羊区', '青羊区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2283, '四川省成都市金牛区', '金牛区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2284, '四川省成都市武侯区', '武侯区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2285, '四川省成都市成华区', '成华区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2286, '四川省成都市龙泉驿区', '龙泉驿区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2287, '四川省成都市青白江区', '青白江区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2288, '四川省成都市新都区', '新都区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2289, '四川省成都市温江区', '温江区', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2290, '四川省成都市金堂县', '金堂县', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2291, '四川省成都市双流县', '双流县', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2292, '四川省成都市郫县', '郫县', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2293, '四川省成都市大邑县', '大邑县', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2294, '四川省成都市蒲江县', '蒲江县', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2295, '四川省成都市新津县', '新津县', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2296, '四川省成都市都江堰市', '都江堰市', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2297, '四川省成都市彭州市', '彭州市', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2298, '四川省成都市邛崃市', '邛崃市', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2299, '四川省成都市崇州市', '崇州市', ',2279,2280,', 2280, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2300, '四川省自贡市', '自贡市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2301, '四川省自贡市自流井区', '自流井区', ',2279,2300,', 2300, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2302, '四川省自贡市贡井区', '贡井区', ',2279,2300,', 2300, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2303, '四川省自贡市大安区', '大安区', ',2279,2300,', 2300, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2304, '四川省自贡市沿滩区', '沿滩区', ',2279,2300,', 2300, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2305, '四川省自贡市荣县', '荣县', ',2279,2300,', 2300, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2306, '四川省自贡市富顺县', '富顺县', ',2279,2300,', 2300, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2307, '四川省攀枝花市', '攀枝花市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2308, '四川省攀枝花市东区', '东区', ',2279,2307,', 2307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2309, '四川省攀枝花市西区', '西区', ',2279,2307,', 2307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2310, '四川省攀枝花市仁和区', '仁和区', ',2279,2307,', 2307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2311, '四川省攀枝花市米易县', '米易县', ',2279,2307,', 2307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2312, '四川省攀枝花市盐边县', '盐边县', ',2279,2307,', 2307, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2313, '四川省泸州市', '泸州市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2314, '四川省泸州市江阳区', '江阳区', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2315, '四川省泸州市纳溪区', '纳溪区', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2316, '四川省泸州市龙马潭区', '龙马潭区', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2317, '四川省泸州市泸县', '泸县', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2318, '四川省泸州市合江县', '合江县', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2319, '四川省泸州市叙永县', '叙永县', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2320, '四川省泸州市古蔺县', '古蔺县', ',2279,2313,', 2313, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2321, '四川省德阳市', '德阳市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2322, '四川省德阳市旌阳区', '旌阳区', ',2279,2321,', 2321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2323, '四川省德阳市中江县', '中江县', ',2279,2321,', 2321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2324, '四川省德阳市罗江县', '罗江县', ',2279,2321,', 2321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2325, '四川省德阳市广汉市', '广汉市', ',2279,2321,', 2321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2326, '四川省德阳市什邡市', '什邡市', ',2279,2321,', 2321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2327, '四川省德阳市绵竹市', '绵竹市', ',2279,2321,', 2321, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2328, '四川省绵阳市', '绵阳市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2329, '四川省绵阳市涪城区', '涪城区', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2330, '四川省绵阳市游仙区', '游仙区', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2331, '四川省绵阳市三台县', '三台县', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2332, '四川省绵阳市盐亭县', '盐亭县', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2333, '四川省绵阳市安县', '安县', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2334, '四川省绵阳市梓潼县', '梓潼县', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2335, '四川省绵阳市北川羌族自治县', '北川羌族自治县', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2336, '四川省绵阳市平武县', '平武县', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2337, '四川省绵阳市江油市', '江油市', ',2279,2328,', 2328, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2338, '四川省广元市', '广元市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2339, '四川省广元市利州区', '利州区', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2340, '四川省广元市元坝区', '元坝区', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2341, '四川省广元市朝天区', '朝天区', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2342, '四川省广元市旺苍县', '旺苍县', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2343, '四川省广元市青川县', '青川县', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2344, '四川省广元市剑阁县', '剑阁县', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2345, '四川省广元市苍溪县', '苍溪县', ',2279,2338,', 2338, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2346, '四川省遂宁市', '遂宁市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2347, '四川省遂宁市船山区', '船山区', ',2279,2346,', 2346, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2348, '四川省遂宁市安居区', '安居区', ',2279,2346,', 2346, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2349, '四川省遂宁市蓬溪县', '蓬溪县', ',2279,2346,', 2346, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2350, '四川省遂宁市射洪县', '射洪县', ',2279,2346,', 2346, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2351, '四川省遂宁市大英县', '大英县', ',2279,2346,', 2346, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2352, '四川省内江市', '内江市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2353, '四川省内江市市中区', '市中区', ',2279,2352,', 2352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2354, '四川省内江市东兴区', '东兴区', ',2279,2352,', 2352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2355, '四川省内江市威远县', '威远县', ',2279,2352,', 2352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2356, '四川省内江市资中县', '资中县', ',2279,2352,', 2352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2357, '四川省内江市隆昌县', '隆昌县', ',2279,2352,', 2352, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2358, '四川省乐山市', '乐山市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2359, '四川省乐山市市中区', '市中区', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2360, '四川省乐山市沙湾区', '沙湾区', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2361, '四川省乐山市五通桥区', '五通桥区', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2362, '四川省乐山市金口河区', '金口河区', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2363, '四川省乐山市犍为县', '犍为县', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2364, '四川省乐山市井研县', '井研县', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2365, '四川省乐山市夹江县', '夹江县', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2366, '四川省乐山市沐川县', '沐川县', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2367, '四川省乐山市峨边彝族自治县', '峨边彝族自治县', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2368, '四川省乐山市马边彝族自治县', '马边彝族自治县', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2369, '四川省乐山市峨眉山市', '峨眉山市', ',2279,2358,', 2358, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2370, '四川省南充市', '南充市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2371, '四川省南充市顺庆区', '顺庆区', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2372, '四川省南充市高坪区', '高坪区', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2373, '四川省南充市嘉陵区', '嘉陵区', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2374, '四川省南充市南部县', '南部县', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2375, '四川省南充市营山县', '营山县', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2376, '四川省南充市蓬安县', '蓬安县', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2377, '四川省南充市仪陇县', '仪陇县', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2378, '四川省南充市西充县', '西充县', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2379, '四川省南充市阆中市', '阆中市', ',2279,2370,', 2370, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2380, '四川省眉山市', '眉山市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2381, '四川省眉山市东坡区', '东坡区', ',2279,2380,', 2380, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2382, '四川省眉山市仁寿县', '仁寿县', ',2279,2380,', 2380, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2383, '四川省眉山市彭山县', '彭山县', ',2279,2380,', 2380, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2384, '四川省眉山市洪雅县', '洪雅县', ',2279,2380,', 2380, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2385, '四川省眉山市丹棱县', '丹棱县', ',2279,2380,', 2380, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2386, '四川省眉山市青神县', '青神县', ',2279,2380,', 2380, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2387, '四川省宜宾市', '宜宾市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2388, '四川省宜宾市翠屏区', '翠屏区', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2389, '四川省宜宾市南溪区', '南溪区', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2390, '四川省宜宾市宜宾县', '宜宾县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2391, '四川省宜宾市江安县', '江安县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2392, '四川省宜宾市长宁县', '长宁县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2393, '四川省宜宾市高县', '高县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2394, '四川省宜宾市珙县', '珙县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2395, '四川省宜宾市筠连县', '筠连县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2396, '四川省宜宾市兴文县', '兴文县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2397, '四川省宜宾市屏山县', '屏山县', ',2279,2387,', 2387, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2398, '四川省广安市', '广安市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2399, '四川省广安市广安区', '广安区', ',2279,2398,', 2398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2400, '四川省广安市岳池县', '岳池县', ',2279,2398,', 2398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2401, '四川省广安市武胜县', '武胜县', ',2279,2398,', 2398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2402, '四川省广安市邻水县', '邻水县', ',2279,2398,', 2398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2403, '四川省广安市华蓥市', '华蓥市', ',2279,2398,', 2398, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2404, '四川省达州市', '达州市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2405, '四川省达州市通川区', '通川区', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2406, '四川省达州市达县', '达县', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2407, '四川省达州市宣汉县', '宣汉县', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2408, '四川省达州市开江县', '开江县', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2409, '四川省达州市大竹县', '大竹县', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2410, '四川省达州市渠县', '渠县', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2411, '四川省达州市万源市', '万源市', ',2279,2404,', 2404, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2412, '四川省雅安市', '雅安市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2413, '四川省雅安市雨城区', '雨城区', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2414, '四川省雅安市名山区', '名山区', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2415, '四川省雅安市荥经县', '荥经县', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2416, '四川省雅安市汉源县', '汉源县', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2417, '四川省雅安市石棉县', '石棉县', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2418, '四川省雅安市天全县', '天全县', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2419, '四川省雅安市芦山县', '芦山县', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2420, '四川省雅安市宝兴县', '宝兴县', ',2279,2412,', 2412, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2421, '四川省巴中市', '巴中市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2422, '四川省巴中市巴州区', '巴州区', ',2279,2421,', 2421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2423, '四川省巴中市通江县', '通江县', ',2279,2421,', 2421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2424, '四川省巴中市南江县', '南江县', ',2279,2421,', 2421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2425, '四川省巴中市平昌县', '平昌县', ',2279,2421,', 2421, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2426, '四川省资阳市', '资阳市', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2427, '四川省资阳市雁江区', '雁江区', ',2279,2426,', 2426, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2428, '四川省资阳市安岳县', '安岳县', ',2279,2426,', 2426, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2429, '四川省资阳市乐至县', '乐至县', ',2279,2426,', 2426, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2430, '四川省资阳市简阳市', '简阳市', ',2279,2426,', 2426, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2431, '四川省阿坝藏族羌族自治州', '阿坝藏族羌族自治州', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2432, '四川省阿坝藏族羌族自治州汶川县', '汶川县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2433, '四川省阿坝藏族羌族自治州理县', '理县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2434, '四川省阿坝藏族羌族自治州茂县', '茂县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2435, '四川省阿坝藏族羌族自治州松潘县', '松潘县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2436, '四川省阿坝藏族羌族自治州九寨沟县', '九寨沟县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2437, '四川省阿坝藏族羌族自治州金川县', '金川县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2438, '四川省阿坝藏族羌族自治州小金县', '小金县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2439, '四川省阿坝藏族羌族自治州黑水县', '黑水县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2440, '四川省阿坝藏族羌族自治州马尔康县', '马尔康县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2441, '四川省阿坝藏族羌族自治州壤塘县', '壤塘县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2442, '四川省阿坝藏族羌族自治州阿坝县', '阿坝县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2443, '四川省阿坝藏族羌族自治州若尔盖县', '若尔盖县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2444, '四川省阿坝藏族羌族自治州红原县', '红原县', ',2279,2431,', 2431, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2445, '四川省甘孜藏族自治州', '甘孜藏族自治州', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2446, '四川省甘孜藏族自治州康定县', '康定县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2447, '四川省甘孜藏族自治州泸定县', '泸定县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2448, '四川省甘孜藏族自治州丹巴县', '丹巴县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2449, '四川省甘孜藏族自治州九龙县', '九龙县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2450, '四川省甘孜藏族自治州雅江县', '雅江县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2451, '四川省甘孜藏族自治州道孚县', '道孚县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2452, '四川省甘孜藏族自治州炉霍县', '炉霍县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2453, '四川省甘孜藏族自治州甘孜县', '甘孜县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2454, '四川省甘孜藏族自治州新龙县', '新龙县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2455, '四川省甘孜藏族自治州德格县', '德格县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2456, '四川省甘孜藏族自治州白玉县', '白玉县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2457, '四川省甘孜藏族自治州石渠县', '石渠县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2458, '四川省甘孜藏族自治州色达县', '色达县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2459, '四川省甘孜藏族自治州理塘县', '理塘县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2460, '四川省甘孜藏族自治州巴塘县', '巴塘县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2461, '四川省甘孜藏族自治州乡城县', '乡城县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2462, '四川省甘孜藏族自治州稻城县', '稻城县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2463, '四川省甘孜藏族自治州得荣县', '得荣县', ',2279,2445,', 2445, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2464, '四川省凉山彝族自治州', '凉山彝族自治州', ',2279,', 2279, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2465, '四川省凉山彝族自治州西昌市', '西昌市', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2466, '四川省凉山彝族自治州木里藏族自治县', '木里藏族自治县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2467, '四川省凉山彝族自治州盐源县', '盐源县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2468, '四川省凉山彝族自治州德昌县', '德昌县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2469, '四川省凉山彝族自治州会理县', '会理县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2470, '四川省凉山彝族自治州会东县', '会东县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2471, '四川省凉山彝族自治州宁南县', '宁南县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2472, '四川省凉山彝族自治州普格县', '普格县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2473, '四川省凉山彝族自治州布拖县', '布拖县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2474, '四川省凉山彝族自治州金阳县', '金阳县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2475, '四川省凉山彝族自治州昭觉县', '昭觉县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2476, '四川省凉山彝族自治州喜德县', '喜德县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2477, '四川省凉山彝族自治州冕宁县', '冕宁县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2478, '四川省凉山彝族自治州越西县', '越西县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2479, '四川省凉山彝族自治州甘洛县', '甘洛县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2480, '四川省凉山彝族自治州美姑县', '美姑县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2481, '四川省凉山彝族自治州雷波县', '雷波县', ',2279,2464,', 2464, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2482, '贵州省', '贵州省', ',', NULL, 23, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2483, '贵州省贵阳市', '贵阳市', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2484, '贵州省贵阳市南明区', '南明区', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2485, '贵州省贵阳市云岩区', '云岩区', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2486, '贵州省贵阳市花溪区', '花溪区', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2487, '贵州省贵阳市乌当区', '乌当区', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2488, '贵州省贵阳市白云区', '白云区', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2489, '贵州省贵阳市小河区', '小河区', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2490, '贵州省贵阳市开阳县', '开阳县', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2491, '贵州省贵阳市息烽县', '息烽县', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2492, '贵州省贵阳市修文县', '修文县', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2493, '贵州省贵阳市清镇市', '清镇市', ',2482,2483,', 2483, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2494, '贵州省六盘水市', '六盘水市', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2495, '贵州省六盘水市钟山区', '钟山区', ',2482,2494,', 2494, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2496, '贵州省六盘水市六枝特区', '六枝特区', ',2482,2494,', 2494, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2497, '贵州省六盘水市水城县', '水城县', ',2482,2494,', 2494, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2498, '贵州省六盘水市盘县', '盘县', ',2482,2494,', 2494, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2499, '贵州省遵义市', '遵义市', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2500, '贵州省遵义市红花岗区', '红花岗区', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2501, '贵州省遵义市汇川区', '汇川区', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2502, '贵州省遵义市遵义县', '遵义县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2503, '贵州省遵义市桐梓县', '桐梓县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2504, '贵州省遵义市绥阳县', '绥阳县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2505, '贵州省遵义市正安县', '正安县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2506, '贵州省遵义市道真仡佬族苗族自治县', '道真仡佬族苗族自治县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2507, '贵州省遵义市务川仡佬族苗族自治县', '务川仡佬族苗族自治县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2508, '贵州省遵义市凤冈县', '凤冈县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2509, '贵州省遵义市湄潭县', '湄潭县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2510, '贵州省遵义市余庆县', '余庆县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2511, '贵州省遵义市习水县', '习水县', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2512, '贵州省遵义市赤水市', '赤水市', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2513, '贵州省遵义市仁怀市', '仁怀市', ',2482,2499,', 2499, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2514, '贵州省安顺市', '安顺市', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2515, '贵州省安顺市西秀区', '西秀区', ',2482,2514,', 2514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2516, '贵州省安顺市平坝县', '平坝县', ',2482,2514,', 2514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2517, '贵州省安顺市普定县', '普定县', ',2482,2514,', 2514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2518, '贵州省安顺市镇宁布依族苗族自治县', '镇宁布依族苗族自治县', ',2482,2514,', 2514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2519, '贵州省安顺市关岭布依族苗族自治县', '关岭布依族苗族自治县', ',2482,2514,', 2514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2520, '贵州省安顺市紫云苗族布依族自治县', '紫云苗族布依族自治县', ',2482,2514,', 2514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2521, '贵州省毕节市', '毕节市', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2522, '贵州省毕节市七星关区', '七星关区', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2523, '贵州省毕节市大方县', '大方县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2524, '贵州省毕节市黔西县', '黔西县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2525, '贵州省毕节市金沙县', '金沙县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2526, '贵州省毕节市织金县', '织金县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2527, '贵州省毕节市纳雍县', '纳雍县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2528, '贵州省毕节市威宁彝族回族苗族自治县', '威宁彝族回族苗族自治县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2529, '贵州省毕节市赫章县', '赫章县', ',2482,2521,', 2521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2530, '贵州省铜仁市', '铜仁市', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2531, '贵州省铜仁市碧江区', '碧江区', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2532, '贵州省铜仁市万山区', '万山区', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2533, '贵州省铜仁市江口县', '江口县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2534, '贵州省铜仁市玉屏侗族自治县', '玉屏侗族自治县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2535, '贵州省铜仁市石阡县', '石阡县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2536, '贵州省铜仁市思南县', '思南县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2537, '贵州省铜仁市印江土家族苗族自治县', '印江土家族苗族自治县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2538, '贵州省铜仁市德江县', '德江县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2539, '贵州省铜仁市沿河土家族自治县', '沿河土家族自治县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2540, '贵州省铜仁市松桃苗族自治县', '松桃苗族自治县', ',2482,2530,', 2530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2541, '贵州省黔西南布依族苗族自治州', '黔西南布依族苗族自治州', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2542, '贵州省黔西南布依族苗族自治州兴义市', '兴义市', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2543, '贵州省黔西南布依族苗族自治州兴仁县', '兴仁县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2544, '贵州省黔西南布依族苗族自治州普安县', '普安县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2545, '贵州省黔西南布依族苗族自治州晴隆县', '晴隆县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2546, '贵州省黔西南布依族苗族自治州贞丰县', '贞丰县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2547, '贵州省黔西南布依族苗族自治州望谟县', '望谟县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2548, '贵州省黔西南布依族苗族自治州册亨县', '册亨县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2549, '贵州省黔西南布依族苗族自治州安龙县', '安龙县', ',2482,2541,', 2541, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2550, '贵州省黔东南苗族侗族自治州', '黔东南苗族侗族自治州', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2551, '贵州省黔东南苗族侗族自治州凯里市', '凯里市', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2552, '贵州省黔东南苗族侗族自治州黄平县', '黄平县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2553, '贵州省黔东南苗族侗族自治州施秉县', '施秉县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2554, '贵州省黔东南苗族侗族自治州三穗县', '三穗县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2555, '贵州省黔东南苗族侗族自治州镇远县', '镇远县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2556, '贵州省黔东南苗族侗族自治州岑巩县', '岑巩县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2557, '贵州省黔东南苗族侗族自治州天柱县', '天柱县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2558, '贵州省黔东南苗族侗族自治州锦屏县', '锦屏县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2559, '贵州省黔东南苗族侗族自治州剑河县', '剑河县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2560, '贵州省黔东南苗族侗族自治州台江县', '台江县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2561, '贵州省黔东南苗族侗族自治州黎平县', '黎平县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2562, '贵州省黔东南苗族侗族自治州榕江县', '榕江县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2563, '贵州省黔东南苗族侗族自治州从江县', '从江县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2564, '贵州省黔东南苗族侗族自治州雷山县', '雷山县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2565, '贵州省黔东南苗族侗族自治州麻江县', '麻江县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2566, '贵州省黔东南苗族侗族自治州丹寨县', '丹寨县', ',2482,2550,', 2550, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2567, '贵州省黔南布依族苗族自治州', '黔南布依族苗族自治州', ',2482,', 2482, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2568, '贵州省黔南布依族苗族自治州都匀市', '都匀市', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2569, '贵州省黔南布依族苗族自治州福泉市', '福泉市', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2570, '贵州省黔南布依族苗族自治州荔波县', '荔波县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2571, '贵州省黔南布依族苗族自治州贵定县', '贵定县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2572, '贵州省黔南布依族苗族自治州瓮安县', '瓮安县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2573, '贵州省黔南布依族苗族自治州独山县', '独山县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2574, '贵州省黔南布依族苗族自治州平塘县', '平塘县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2575, '贵州省黔南布依族苗族自治州罗甸县', '罗甸县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2576, '贵州省黔南布依族苗族自治州长顺县', '长顺县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2577, '贵州省黔南布依族苗族自治州龙里县', '龙里县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2578, '贵州省黔南布依族苗族自治州惠水县', '惠水县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2579, '贵州省黔南布依族苗族自治州三都水族自治县', '三都水族自治县', ',2482,2567,', 2567, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2580, '云南省', '云南省', ',', NULL, 24, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2581, '云南省昆明市', '昆明市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2582, '云南省昆明市五华区', '五华区', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2583, '云南省昆明市盘龙区', '盘龙区', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2584, '云南省昆明市官渡区', '官渡区', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2585, '云南省昆明市西山区', '西山区', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2586, '云南省昆明市东川区', '东川区', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2587, '云南省昆明市呈贡区', '呈贡区', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2588, '云南省昆明市晋宁县', '晋宁县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2589, '云南省昆明市富民县', '富民县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2590, '云南省昆明市宜良县', '宜良县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2591, '云南省昆明市石林彝族自治县', '石林彝族自治县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2592, '云南省昆明市嵩明县', '嵩明县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2593, '云南省昆明市禄劝彝族苗族自治县', '禄劝彝族苗族自治县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2594, '云南省昆明市寻甸回族彝族自治县', '寻甸回族彝族自治县', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2595, '云南省昆明市安宁市', '安宁市', ',2580,2581,', 2581, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2596, '云南省曲靖市', '曲靖市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2597, '云南省曲靖市麒麟区', '麒麟区', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2598, '云南省曲靖市马龙县', '马龙县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2599, '云南省曲靖市陆良县', '陆良县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2600, '云南省曲靖市师宗县', '师宗县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2601, '云南省曲靖市罗平县', '罗平县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2602, '云南省曲靖市富源县', '富源县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2603, '云南省曲靖市会泽县', '会泽县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2604, '云南省曲靖市沾益县', '沾益县', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2605, '云南省曲靖市宣威市', '宣威市', ',2580,2596,', 2596, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2606, '云南省玉溪市', '玉溪市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2607, '云南省玉溪市红塔区', '红塔区', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2608, '云南省玉溪市江川县', '江川县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2609, '云南省玉溪市澄江县', '澄江县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2610, '云南省玉溪市通海县', '通海县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2611, '云南省玉溪市华宁县', '华宁县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2612, '云南省玉溪市易门县', '易门县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2613, '云南省玉溪市峨山彝族自治县', '峨山彝族自治县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2614, '云南省玉溪市新平彝族傣族自治县', '新平彝族傣族自治县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2615, '云南省玉溪市元江哈尼族彝族傣族自治县', '元江哈尼族彝族傣族自治县', ',2580,2606,', 2606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2616, '云南省保山市', '保山市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2617, '云南省保山市隆阳区', '隆阳区', ',2580,2616,', 2616, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2618, '云南省保山市施甸县', '施甸县', ',2580,2616,', 2616, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2619, '云南省保山市腾冲县', '腾冲县', ',2580,2616,', 2616, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2620, '云南省保山市龙陵县', '龙陵县', ',2580,2616,', 2616, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2621, '云南省保山市昌宁县', '昌宁县', ',2580,2616,', 2616, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2622, '云南省昭通市', '昭通市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2623, '云南省昭通市昭阳区', '昭阳区', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2624, '云南省昭通市鲁甸县', '鲁甸县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2625, '云南省昭通市巧家县', '巧家县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2626, '云南省昭通市盐津县', '盐津县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2627, '云南省昭通市大关县', '大关县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2628, '云南省昭通市永善县', '永善县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2629, '云南省昭通市绥江县', '绥江县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2630, '云南省昭通市镇雄县', '镇雄县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2631, '云南省昭通市彝良县', '彝良县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2632, '云南省昭通市威信县', '威信县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2633, '云南省昭通市水富县', '水富县', ',2580,2622,', 2622, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2634, '云南省丽江市', '丽江市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2635, '云南省丽江市古城区', '古城区', ',2580,2634,', 2634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2636, '云南省丽江市玉龙纳西族自治县', '玉龙纳西族自治县', ',2580,2634,', 2634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2637, '云南省丽江市永胜县', '永胜县', ',2580,2634,', 2634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2638, '云南省丽江市华坪县', '华坪县', ',2580,2634,', 2634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2639, '云南省丽江市宁蒗彝族自治县', '宁蒗彝族自治县', ',2580,2634,', 2634, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2640, '云南省普洱市', '普洱市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2641, '云南省普洱市思茅区', '思茅区', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2642, '云南省普洱市宁洱哈尼族彝族自治县', '宁洱哈尼族彝族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2643, '云南省普洱市墨江哈尼族自治县', '墨江哈尼族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2644, '云南省普洱市景东彝族自治县', '景东彝族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2645, '云南省普洱市景谷傣族彝族自治县', '景谷傣族彝族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2646, '云南省普洱市镇沅彝族哈尼族拉祜族自治县', '镇沅彝族哈尼族拉祜族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2647, '云南省普洱市江城哈尼族彝族自治县', '江城哈尼族彝族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2648, '云南省普洱市孟连傣族拉祜族佤族自治县', '孟连傣族拉祜族佤族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2649, '云南省普洱市澜沧拉祜族自治县', '澜沧拉祜族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2650, '云南省普洱市西盟佤族自治县', '西盟佤族自治县', ',2580,2640,', 2640, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2651, '云南省临沧市', '临沧市', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2652, '云南省临沧市临翔区', '临翔区', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2653, '云南省临沧市凤庆县', '凤庆县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2654, '云南省临沧市云县', '云县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2655, '云南省临沧市永德县', '永德县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2656, '云南省临沧市镇康县', '镇康县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2657, '云南省临沧市双江拉祜族佤族布朗族傣族自治县', '双江拉祜族佤族布朗族傣族自治县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2658, '云南省临沧市耿马傣族佤族自治县', '耿马傣族佤族自治县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2659, '云南省临沧市沧源佤族自治县', '沧源佤族自治县', ',2580,2651,', 2651, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2660, '云南省楚雄彝族自治州', '楚雄彝族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2661, '云南省楚雄彝族自治州楚雄市', '楚雄市', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2662, '云南省楚雄彝族自治州双柏县', '双柏县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2663, '云南省楚雄彝族自治州牟定县', '牟定县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2664, '云南省楚雄彝族自治州南华县', '南华县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2665, '云南省楚雄彝族自治州姚安县', '姚安县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2666, '云南省楚雄彝族自治州大姚县', '大姚县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2667, '云南省楚雄彝族自治州永仁县', '永仁县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2668, '云南省楚雄彝族自治州元谋县', '元谋县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2669, '云南省楚雄彝族自治州武定县', '武定县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2670, '云南省楚雄彝族自治州禄丰县', '禄丰县', ',2580,2660,', 2660, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2671, '云南省红河哈尼族彝族自治州', '红河哈尼族彝族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2672, '云南省红河哈尼族彝族自治州个旧市', '个旧市', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2673, '云南省红河哈尼族彝族自治州开远市', '开远市', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2674, '云南省红河哈尼族彝族自治州蒙自市', '蒙自市', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2675, '云南省红河哈尼族彝族自治州屏边苗族自治县', '屏边苗族自治县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2676, '云南省红河哈尼族彝族自治州建水县', '建水县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2677, '云南省红河哈尼族彝族自治州石屏县', '石屏县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2678, '云南省红河哈尼族彝族自治州弥勒县', '弥勒县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2679, '云南省红河哈尼族彝族自治州泸西县', '泸西县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2680, '云南省红河哈尼族彝族自治州元阳县', '元阳县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2681, '云南省红河哈尼族彝族自治州红河县', '红河县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2682, '云南省红河哈尼族彝族自治州金平苗族瑶族傣族自治县', '金平苗族瑶族傣族自治县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2683, '云南省红河哈尼族彝族自治州绿春县', '绿春县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2684, '云南省红河哈尼族彝族自治州河口瑶族自治县', '河口瑶族自治县', ',2580,2671,', 2671, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2685, '云南省文山壮族苗族自治州', '文山壮族苗族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2686, '云南省文山壮族苗族自治州文山市', '文山市', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2687, '云南省文山壮族苗族自治州砚山县', '砚山县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2688, '云南省文山壮族苗族自治州西畴县', '西畴县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2689, '云南省文山壮族苗族自治州麻栗坡县', '麻栗坡县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2690, '云南省文山壮族苗族自治州马关县', '马关县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2691, '云南省文山壮族苗族自治州丘北县', '丘北县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2692, '云南省文山壮族苗族自治州广南县', '广南县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2693, '云南省文山壮族苗族自治州富宁县', '富宁县', ',2580,2685,', 2685, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2694, '云南省西双版纳傣族自治州', '西双版纳傣族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2695, '云南省西双版纳傣族自治州景洪市', '景洪市', ',2580,2694,', 2694, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2696, '云南省西双版纳傣族自治州勐海县', '勐海县', ',2580,2694,', 2694, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2697, '云南省西双版纳傣族自治州勐腊县', '勐腊县', ',2580,2694,', 2694, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2698, '云南省大理白族自治州', '大理白族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2699, '云南省大理白族自治州大理市', '大理市', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2700, '云南省大理白族自治州漾濞彝族自治县', '漾濞彝族自治县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2701, '云南省大理白族自治州祥云县', '祥云县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2702, '云南省大理白族自治州宾川县', '宾川县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2703, '云南省大理白族自治州弥渡县', '弥渡县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2704, '云南省大理白族自治州南涧彝族自治县', '南涧彝族自治县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2705, '云南省大理白族自治州巍山彝族回族自治县', '巍山彝族回族自治县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2706, '云南省大理白族自治州永平县', '永平县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2707, '云南省大理白族自治州云龙县', '云龙县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2708, '云南省大理白族自治州洱源县', '洱源县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2709, '云南省大理白族自治州剑川县', '剑川县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2710, '云南省大理白族自治州鹤庆县', '鹤庆县', ',2580,2698,', 2698, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2711, '云南省德宏傣族景颇族自治州', '德宏傣族景颇族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2712, '云南省德宏傣族景颇族自治州瑞丽市', '瑞丽市', ',2580,2711,', 2711, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2713, '云南省德宏傣族景颇族自治州芒市', '芒市', ',2580,2711,', 2711, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2714, '云南省德宏傣族景颇族自治州梁河县', '梁河县', ',2580,2711,', 2711, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2715, '云南省德宏傣族景颇族自治州盈江县', '盈江县', ',2580,2711,', 2711, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2716, '云南省德宏傣族景颇族自治州陇川县', '陇川县', ',2580,2711,', 2711, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2717, '云南省怒江傈僳族自治州', '怒江傈僳族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2718, '云南省怒江傈僳族自治州泸水县', '泸水县', ',2580,2717,', 2717, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2719, '云南省怒江傈僳族自治州福贡县', '福贡县', ',2580,2717,', 2717, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2720, '云南省怒江傈僳族自治州贡山独龙族怒族自治县', '贡山独龙族怒族自治县', ',2580,2717,', 2717, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2721, '云南省怒江傈僳族自治州兰坪白族普米族自治县', '兰坪白族普米族自治县', ',2580,2717,', 2717, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2722, '云南省迪庆藏族自治州', '迪庆藏族自治州', ',2580,', 2580, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2723, '云南省迪庆藏族自治州香格里拉县', '香格里拉县', ',2580,2722,', 2722, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2724, '云南省迪庆藏族自治州德钦县', '德钦县', ',2580,2722,', 2722, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2725, '云南省迪庆藏族自治州维西傈僳族自治县', '维西傈僳族自治县', ',2580,2722,', 2722, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2726, '西藏自治区', '西藏自治区', ',', NULL, 25, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2727, '西藏自治区拉萨市', '拉萨市', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2728, '西藏自治区拉萨市城关区', '城关区', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2729, '西藏自治区拉萨市林周县', '林周县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2730, '西藏自治区拉萨市当雄县', '当雄县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2731, '西藏自治区拉萨市尼木县', '尼木县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2732, '西藏自治区拉萨市曲水县', '曲水县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2733, '西藏自治区拉萨市堆龙德庆县', '堆龙德庆县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2734, '西藏自治区拉萨市达孜县', '达孜县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2735, '西藏自治区拉萨市墨竹工卡县', '墨竹工卡县', ',2726,2727,', 2727, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2736, '西藏自治区昌都地区', '昌都地区', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2737, '西藏自治区昌都地区昌都县', '昌都县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2738, '西藏自治区昌都地区江达县', '江达县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2739, '西藏自治区昌都地区贡觉县', '贡觉县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2740, '西藏自治区昌都地区类乌齐县', '类乌齐县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2741, '西藏自治区昌都地区丁青县', '丁青县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2742, '西藏自治区昌都地区察雅县', '察雅县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2743, '西藏自治区昌都地区八宿县', '八宿县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2744, '西藏自治区昌都地区左贡县', '左贡县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2745, '西藏自治区昌都地区芒康县', '芒康县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2746, '西藏自治区昌都地区洛隆县', '洛隆县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2747, '西藏自治区昌都地区边坝县', '边坝县', ',2726,2736,', 2736, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2748, '西藏自治区山南地区', '山南地区', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2749, '西藏自治区山南地区乃东县', '乃东县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2750, '西藏自治区山南地区扎囊县', '扎囊县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2751, '西藏自治区山南地区贡嘎县', '贡嘎县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2752, '西藏自治区山南地区桑日县', '桑日县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2753, '西藏自治区山南地区琼结县', '琼结县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2754, '西藏自治区山南地区曲松县', '曲松县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2755, '西藏自治区山南地区措美县', '措美县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2756, '西藏自治区山南地区洛扎县', '洛扎县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2757, '西藏自治区山南地区加查县', '加查县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2758, '西藏自治区山南地区隆子县', '隆子县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2759, '西藏自治区山南地区错那县', '错那县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2760, '西藏自治区山南地区浪卡子县', '浪卡子县', ',2726,2748,', 2748, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2761, '西藏自治区日喀则地区', '日喀则地区', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2762, '西藏自治区日喀则地区日喀则市', '日喀则市', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2763, '西藏自治区日喀则地区南木林县', '南木林县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2764, '西藏自治区日喀则地区江孜县', '江孜县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2765, '西藏自治区日喀则地区定日县', '定日县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2766, '西藏自治区日喀则地区萨迦县', '萨迦县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2767, '西藏自治区日喀则地区拉孜县', '拉孜县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2768, '西藏自治区日喀则地区昂仁县', '昂仁县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2769, '西藏自治区日喀则地区谢通门县', '谢通门县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2770, '西藏自治区日喀则地区白朗县', '白朗县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2771, '西藏自治区日喀则地区仁布县', '仁布县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2772, '西藏自治区日喀则地区康马县', '康马县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2773, '西藏自治区日喀则地区定结县', '定结县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2774, '西藏自治区日喀则地区仲巴县', '仲巴县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2775, '西藏自治区日喀则地区亚东县', '亚东县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2776, '西藏自治区日喀则地区吉隆县', '吉隆县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2777, '西藏自治区日喀则地区聂拉木县', '聂拉木县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2778, '西藏自治区日喀则地区萨嘎县', '萨嘎县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2779, '西藏自治区日喀则地区岗巴县', '岗巴县', ',2726,2761,', 2761, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2780, '西藏自治区那曲地区', '那曲地区', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2781, '西藏自治区那曲地区那曲县', '那曲县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2782, '西藏自治区那曲地区嘉黎县', '嘉黎县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2783, '西藏自治区那曲地区比如县', '比如县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2784, '西藏自治区那曲地区聂荣县', '聂荣县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2785, '西藏自治区那曲地区安多县', '安多县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2786, '西藏自治区那曲地区申扎县', '申扎县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2787, '西藏自治区那曲地区索县', '索县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2788, '西藏自治区那曲地区班戈县', '班戈县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2789, '西藏自治区那曲地区巴青县', '巴青县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2790, '西藏自治区那曲地区尼玛县', '尼玛县', ',2726,2780,', 2780, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2791, '西藏自治区阿里地区', '阿里地区', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2792, '西藏自治区阿里地区普兰县', '普兰县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2793, '西藏自治区阿里地区札达县', '札达县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2794, '西藏自治区阿里地区噶尔县', '噶尔县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2795, '西藏自治区阿里地区日土县', '日土县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2796, '西藏自治区阿里地区革吉县', '革吉县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2797, '西藏自治区阿里地区改则县', '改则县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2798, '西藏自治区阿里地区措勤县', '措勤县', ',2726,2791,', 2791, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2799, '西藏自治区林芝地区', '林芝地区', ',2726,', 2726, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2800, '西藏自治区林芝地区林芝县', '林芝县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2801, '西藏自治区林芝地区工布江达县', '工布江达县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2802, '西藏自治区林芝地区米林县', '米林县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2803, '西藏自治区林芝地区墨脱县', '墨脱县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2804, '西藏自治区林芝地区波密县', '波密县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2805, '西藏自治区林芝地区察隅县', '察隅县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2806, '西藏自治区林芝地区朗县', '朗县', ',2726,2799,', 2799, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2807, '陕西省', '陕西省', ',', NULL, 26, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2808, '陕西省西安市', '西安市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2809, '陕西省西安市新城区', '新城区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2810, '陕西省西安市碑林区', '碑林区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2811, '陕西省西安市莲湖区', '莲湖区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2812, '陕西省西安市灞桥区', '灞桥区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2813, '陕西省西安市未央区', '未央区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2814, '陕西省西安市雁塔区', '雁塔区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2815, '陕西省西安市阎良区', '阎良区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2816, '陕西省西安市临潼区', '临潼区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2817, '陕西省西安市长安区', '长安区', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2818, '陕西省西安市蓝田县', '蓝田县', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2819, '陕西省西安市周至县', '周至县', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2820, '陕西省西安市户县', '户县', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2821, '陕西省西安市高陵县', '高陵县', ',2807,2808,', 2808, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2822, '陕西省铜川市', '铜川市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2823, '陕西省铜川市王益区', '王益区', ',2807,2822,', 2822, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2824, '陕西省铜川市印台区', '印台区', ',2807,2822,', 2822, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2825, '陕西省铜川市耀州区', '耀州区', ',2807,2822,', 2822, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2826, '陕西省铜川市宜君县', '宜君县', ',2807,2822,', 2822, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2827, '陕西省宝鸡市', '宝鸡市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2828, '陕西省宝鸡市渭滨区', '渭滨区', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2829, '陕西省宝鸡市金台区', '金台区', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2830, '陕西省宝鸡市陈仓区', '陈仓区', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2831, '陕西省宝鸡市凤翔县', '凤翔县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2832, '陕西省宝鸡市岐山县', '岐山县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2833, '陕西省宝鸡市扶风县', '扶风县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2834, '陕西省宝鸡市眉县', '眉县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2835, '陕西省宝鸡市陇县', '陇县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2836, '陕西省宝鸡市千阳县', '千阳县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2837, '陕西省宝鸡市麟游县', '麟游县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2838, '陕西省宝鸡市凤县', '凤县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2839, '陕西省宝鸡市太白县', '太白县', ',2807,2827,', 2827, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2840, '陕西省咸阳市', '咸阳市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2841, '陕西省咸阳市秦都区', '秦都区', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2842, '陕西省咸阳市杨陵区', '杨陵区', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2843, '陕西省咸阳市渭城区', '渭城区', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2844, '陕西省咸阳市三原县', '三原县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2845, '陕西省咸阳市泾阳县', '泾阳县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2846, '陕西省咸阳市乾县', '乾县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2847, '陕西省咸阳市礼泉县', '礼泉县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2848, '陕西省咸阳市永寿县', '永寿县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2849, '陕西省咸阳市彬县', '彬县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2850, '陕西省咸阳市长武县', '长武县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2851, '陕西省咸阳市旬邑县', '旬邑县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2852, '陕西省咸阳市淳化县', '淳化县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2853, '陕西省咸阳市武功县', '武功县', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2854, '陕西省咸阳市兴平市', '兴平市', ',2807,2840,', 2840, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2855, '陕西省渭南市', '渭南市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2856, '陕西省渭南市临渭区', '临渭区', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2857, '陕西省渭南市华县', '华县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2858, '陕西省渭南市潼关县', '潼关县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2859, '陕西省渭南市大荔县', '大荔县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2860, '陕西省渭南市合阳县', '合阳县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2861, '陕西省渭南市澄城县', '澄城县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2862, '陕西省渭南市蒲城县', '蒲城县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2863, '陕西省渭南市白水县', '白水县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2864, '陕西省渭南市富平县', '富平县', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2865, '陕西省渭南市韩城市', '韩城市', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2866, '陕西省渭南市华阴市', '华阴市', ',2807,2855,', 2855, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2867, '陕西省延安市', '延安市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2868, '陕西省延安市宝塔区', '宝塔区', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2869, '陕西省延安市延长县', '延长县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2870, '陕西省延安市延川县', '延川县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2871, '陕西省延安市子长县', '子长县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2872, '陕西省延安市安塞县', '安塞县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2873, '陕西省延安市志丹县', '志丹县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2874, '陕西省延安市吴起县', '吴起县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2875, '陕西省延安市甘泉县', '甘泉县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2876, '陕西省延安市富县', '富县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2877, '陕西省延安市洛川县', '洛川县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2878, '陕西省延安市宜川县', '宜川县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2879, '陕西省延安市黄龙县', '黄龙县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2880, '陕西省延安市黄陵县', '黄陵县', ',2807,2867,', 2867, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2881, '陕西省汉中市', '汉中市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2882, '陕西省汉中市汉台区', '汉台区', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2883, '陕西省汉中市南郑县', '南郑县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2884, '陕西省汉中市城固县', '城固县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2885, '陕西省汉中市洋县', '洋县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2886, '陕西省汉中市西乡县', '西乡县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2887, '陕西省汉中市勉县', '勉县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2888, '陕西省汉中市宁强县', '宁强县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2889, '陕西省汉中市略阳县', '略阳县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2890, '陕西省汉中市镇巴县', '镇巴县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2891, '陕西省汉中市留坝县', '留坝县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2892, '陕西省汉中市佛坪县', '佛坪县', ',2807,2881,', 2881, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2893, '陕西省榆林市', '榆林市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2894, '陕西省榆林市榆阳区', '榆阳区', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2895, '陕西省榆林市神木县', '神木县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2896, '陕西省榆林市府谷县', '府谷县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2897, '陕西省榆林市横山县', '横山县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2898, '陕西省榆林市靖边县', '靖边县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2899, '陕西省榆林市定边县', '定边县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2900, '陕西省榆林市绥德县', '绥德县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2901, '陕西省榆林市米脂县', '米脂县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2902, '陕西省榆林市佳县', '佳县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2903, '陕西省榆林市吴堡县', '吴堡县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2904, '陕西省榆林市清涧县', '清涧县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2905, '陕西省榆林市子洲县', '子洲县', ',2807,2893,', 2893, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2906, '陕西省安康市', '安康市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2907, '陕西省安康市汉滨区', '汉滨区', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2908, '陕西省安康市汉阴县', '汉阴县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2909, '陕西省安康市石泉县', '石泉县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2910, '陕西省安康市宁陕县', '宁陕县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2911, '陕西省安康市紫阳县', '紫阳县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2912, '陕西省安康市岚皋县', '岚皋县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2913, '陕西省安康市平利县', '平利县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2914, '陕西省安康市镇坪县', '镇坪县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2915, '陕西省安康市旬阳县', '旬阳县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2916, '陕西省安康市白河县', '白河县', ',2807,2906,', 2906, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2917, '陕西省商洛市', '商洛市', ',2807,', 2807, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2918, '陕西省商洛市商州区', '商州区', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2919, '陕西省商洛市洛南县', '洛南县', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2920, '陕西省商洛市丹凤县', '丹凤县', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2921, '陕西省商洛市商南县', '商南县', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2922, '陕西省商洛市山阳县', '山阳县', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2923, '陕西省商洛市镇安县', '镇安县', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2924, '陕西省商洛市柞水县', '柞水县', ',2807,2917,', 2917, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2925, '甘肃省', '甘肃省', ',', NULL, 27, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2926, '甘肃省兰州市', '兰州市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2927, '甘肃省兰州市城关区', '城关区', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2928, '甘肃省兰州市七里河区', '七里河区', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2929, '甘肃省兰州市西固区', '西固区', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2930, '甘肃省兰州市安宁区', '安宁区', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2931, '甘肃省兰州市红古区', '红古区', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2932, '甘肃省兰州市永登县', '永登县', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2933, '甘肃省兰州市皋兰县', '皋兰县', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2934, '甘肃省兰州市榆中县', '榆中县', ',2925,2926,', 2926, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2935, '甘肃省嘉峪关市', '嘉峪关市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2936, '甘肃省金昌市', '金昌市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2937, '甘肃省金昌市金川区', '金川区', ',2925,2936,', 2936, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2938, '甘肃省金昌市永昌县', '永昌县', ',2925,2936,', 2936, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2939, '甘肃省白银市', '白银市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2940, '甘肃省白银市白银区', '白银区', ',2925,2939,', 2939, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2941, '甘肃省白银市平川区', '平川区', ',2925,2939,', 2939, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2942, '甘肃省白银市靖远县', '靖远县', ',2925,2939,', 2939, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2943, '甘肃省白银市会宁县', '会宁县', ',2925,2939,', 2939, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2944, '甘肃省白银市景泰县', '景泰县', ',2925,2939,', 2939, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2945, '甘肃省天水市', '天水市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2946, '甘肃省天水市秦州区', '秦州区', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2947, '甘肃省天水市麦积区', '麦积区', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2948, '甘肃省天水市清水县', '清水县', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2949, '甘肃省天水市秦安县', '秦安县', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2950, '甘肃省天水市甘谷县', '甘谷县', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2951, '甘肃省天水市武山县', '武山县', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2952, '甘肃省天水市张家川回族自治县', '张家川回族自治县', ',2925,2945,', 2945, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2953, '甘肃省武威市', '武威市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2954, '甘肃省武威市凉州区', '凉州区', ',2925,2953,', 2953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2955, '甘肃省武威市民勤县', '民勤县', ',2925,2953,', 2953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2956, '甘肃省武威市古浪县', '古浪县', ',2925,2953,', 2953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2957, '甘肃省武威市天祝藏族自治县', '天祝藏族自治县', ',2925,2953,', 2953, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2958, '甘肃省张掖市', '张掖市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2959, '甘肃省张掖市甘州区', '甘州区', ',2925,2958,', 2958, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2960, '甘肃省张掖市肃南裕固族自治县', '肃南裕固族自治县', ',2925,2958,', 2958, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2961, '甘肃省张掖市民乐县', '民乐县', ',2925,2958,', 2958, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2962, '甘肃省张掖市临泽县', '临泽县', ',2925,2958,', 2958, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2963, '甘肃省张掖市高台县', '高台县', ',2925,2958,', 2958, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2964, '甘肃省张掖市山丹县', '山丹县', ',2925,2958,', 2958, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2965, '甘肃省平凉市', '平凉市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2966, '甘肃省平凉市崆峒区', '崆峒区', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2967, '甘肃省平凉市泾川县', '泾川县', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2968, '甘肃省平凉市灵台县', '灵台县', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2969, '甘肃省平凉市崇信县', '崇信县', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2970, '甘肃省平凉市华亭县', '华亭县', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2971, '甘肃省平凉市庄浪县', '庄浪县', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2972, '甘肃省平凉市静宁县', '静宁县', ',2925,2965,', 2965, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2973, '甘肃省酒泉市', '酒泉市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2974, '甘肃省酒泉市肃州区', '肃州区', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2975, '甘肃省酒泉市金塔县', '金塔县', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2976, '甘肃省酒泉市瓜州县', '瓜州县', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2977, '甘肃省酒泉市肃北蒙古族自治县', '肃北蒙古族自治县', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2978, '甘肃省酒泉市阿克塞哈萨克族自治县', '阿克塞哈萨克族自治县', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2979, '甘肃省酒泉市玉门市', '玉门市', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2980, '甘肃省酒泉市敦煌市', '敦煌市', ',2925,2973,', 2973, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2981, '甘肃省庆阳市', '庆阳市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2982, '甘肃省庆阳市西峰区', '西峰区', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2983, '甘肃省庆阳市庆城县', '庆城县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2984, '甘肃省庆阳市环县', '环县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2985, '甘肃省庆阳市华池县', '华池县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2986, '甘肃省庆阳市合水县', '合水县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2987, '甘肃省庆阳市正宁县', '正宁县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2988, '甘肃省庆阳市宁县', '宁县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2989, '甘肃省庆阳市镇原县', '镇原县', ',2925,2981,', 2981, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2990, '甘肃省定西市', '定西市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2991, '甘肃省定西市安定区', '安定区', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2992, '甘肃省定西市通渭县', '通渭县', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2993, '甘肃省定西市陇西县', '陇西县', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2994, '甘肃省定西市渭源县', '渭源县', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2995, '甘肃省定西市临洮县', '临洮县', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2996, '甘肃省定西市漳县', '漳县', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2997, '甘肃省定西市岷县', '岷县', ',2925,2990,', 2990, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2998, '甘肃省陇南市', '陇南市', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (2999, '甘肃省陇南市武都区', '武都区', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3000, '甘肃省陇南市成县', '成县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3001, '甘肃省陇南市文县', '文县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3002, '甘肃省陇南市宕昌县', '宕昌县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3003, '甘肃省陇南市康县', '康县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3004, '甘肃省陇南市西和县', '西和县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3005, '甘肃省陇南市礼县', '礼县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3006, '甘肃省陇南市徽县', '徽县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3007, '甘肃省陇南市两当县', '两当县', ',2925,2998,', 2998, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3008, '甘肃省临夏回族自治州', '临夏回族自治州', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3009, '甘肃省临夏回族自治州临夏市', '临夏市', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3010, '甘肃省临夏回族自治州临夏县', '临夏县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3011, '甘肃省临夏回族自治州康乐县', '康乐县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3012, '甘肃省临夏回族自治州永靖县', '永靖县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3013, '甘肃省临夏回族自治州广河县', '广河县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3014, '甘肃省临夏回族自治州和政县', '和政县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3015, '甘肃省临夏回族自治州东乡族自治县', '东乡族自治县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3016, '甘肃省临夏回族自治州积石山保安族东乡族撒拉族自治县', '积石山保安族东乡族撒拉族自治县', ',2925,3008,', 3008, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3017, '甘肃省甘南藏族自治州', '甘南藏族自治州', ',2925,', 2925, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3018, '甘肃省甘南藏族自治州合作市', '合作市', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3019, '甘肃省甘南藏族自治州临潭县', '临潭县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3020, '甘肃省甘南藏族自治州卓尼县', '卓尼县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3021, '甘肃省甘南藏族自治州舟曲县', '舟曲县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3022, '甘肃省甘南藏族自治州迭部县', '迭部县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3023, '甘肃省甘南藏族自治州玛曲县', '玛曲县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3024, '甘肃省甘南藏族自治州碌曲县', '碌曲县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3025, '甘肃省甘南藏族自治州夏河县', '夏河县', ',2925,3017,', 3017, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3026, '青海省', '青海省', ',', NULL, 28, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3027, '青海省西宁市', '西宁市', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3028, '青海省西宁市城东区', '城东区', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3029, '青海省西宁市城中区', '城中区', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3030, '青海省西宁市城西区', '城西区', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3031, '青海省西宁市城北区', '城北区', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3032, '青海省西宁市大通回族土族自治县', '大通回族土族自治县', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3033, '青海省西宁市湟中县', '湟中县', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3034, '青海省西宁市湟源县', '湟源县', ',3026,3027,', 3027, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3035, '青海省海东地区', '海东地区', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3036, '青海省海东地区平安县', '平安县', ',3026,3035,', 3035, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3037, '青海省海东地区民和回族土族自治县', '民和回族土族自治县', ',3026,3035,', 3035, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3038, '青海省海东地区乐都县', '乐都县', ',3026,3035,', 3035, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3039, '青海省海东地区互助土族自治县', '互助土族自治县', ',3026,3035,', 3035, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3040, '青海省海东地区化隆回族自治县', '化隆回族自治县', ',3026,3035,', 3035, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3041, '青海省海东地区循化撒拉族自治县', '循化撒拉族自治县', ',3026,3035,', 3035, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3042, '青海省海北藏族自治州', '海北藏族自治州', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3043, '青海省海北藏族自治州门源回族自治县', '门源回族自治县', ',3026,3042,', 3042, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3044, '青海省海北藏族自治州祁连县', '祁连县', ',3026,3042,', 3042, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3045, '青海省海北藏族自治州海晏县', '海晏县', ',3026,3042,', 3042, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3046, '青海省海北藏族自治州刚察县', '刚察县', ',3026,3042,', 3042, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3047, '青海省黄南藏族自治州', '黄南藏族自治州', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3048, '青海省黄南藏族自治州同仁县', '同仁县', ',3026,3047,', 3047, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3049, '青海省黄南藏族自治州尖扎县', '尖扎县', ',3026,3047,', 3047, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3050, '青海省黄南藏族自治州泽库县', '泽库县', ',3026,3047,', 3047, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3051, '青海省黄南藏族自治州河南蒙古族自治县', '河南蒙古族自治县', ',3026,3047,', 3047, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3052, '青海省海南藏族自治州', '海南藏族自治州', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3053, '青海省海南藏族自治州共和县', '共和县', ',3026,3052,', 3052, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3054, '青海省海南藏族自治州同德县', '同德县', ',3026,3052,', 3052, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3055, '青海省海南藏族自治州贵德县', '贵德县', ',3026,3052,', 3052, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3056, '青海省海南藏族自治州兴海县', '兴海县', ',3026,3052,', 3052, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3057, '青海省海南藏族自治州贵南县', '贵南县', ',3026,3052,', 3052, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3058, '青海省果洛藏族自治州', '果洛藏族自治州', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3059, '青海省果洛藏族自治州玛沁县', '玛沁县', ',3026,3058,', 3058, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3060, '青海省果洛藏族自治州班玛县', '班玛县', ',3026,3058,', 3058, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3061, '青海省果洛藏族自治州甘德县', '甘德县', ',3026,3058,', 3058, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3062, '青海省果洛藏族自治州达日县', '达日县', ',3026,3058,', 3058, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3063, '青海省果洛藏族自治州久治县', '久治县', ',3026,3058,', 3058, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3064, '青海省果洛藏族自治州玛多县', '玛多县', ',3026,3058,', 3058, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3065, '青海省玉树藏族自治州', '玉树藏族自治州', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3066, '青海省玉树藏族自治州玉树县', '玉树县', ',3026,3065,', 3065, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3067, '青海省玉树藏族自治州杂多县', '杂多县', ',3026,3065,', 3065, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3068, '青海省玉树藏族自治州称多县', '称多县', ',3026,3065,', 3065, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3069, '青海省玉树藏族自治州治多县', '治多县', ',3026,3065,', 3065, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3070, '青海省玉树藏族自治州囊谦县', '囊谦县', ',3026,3065,', 3065, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3071, '青海省玉树藏族自治州曲麻莱县', '曲麻莱县', ',3026,3065,', 3065, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3072, '青海省海西蒙古族藏族自治州', '海西蒙古族藏族自治州', ',3026,', 3026, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3073, '青海省海西蒙古族藏族自治州格尔木市', '格尔木市', ',3026,3072,', 3072, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3074, '青海省海西蒙古族藏族自治州德令哈市', '德令哈市', ',3026,3072,', 3072, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3075, '青海省海西蒙古族藏族自治州乌兰县', '乌兰县', ',3026,3072,', 3072, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3076, '青海省海西蒙古族藏族自治州都兰县', '都兰县', ',3026,3072,', 3072, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3077, '青海省海西蒙古族藏族自治州天峻县', '天峻县', ',3026,3072,', 3072, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3078, '宁夏回族自治区', '宁夏回族自治区', ',', NULL, 29, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3079, '宁夏回族自治区银川市', '银川市', ',3078,', 3078, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3080, '宁夏回族自治区银川市兴庆区', '兴庆区', ',3078,3079,', 3079, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3081, '宁夏回族自治区银川市西夏区', '西夏区', ',3078,3079,', 3079, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3082, '宁夏回族自治区银川市金凤区', '金凤区', ',3078,3079,', 3079, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3083, '宁夏回族自治区银川市永宁县', '永宁县', ',3078,3079,', 3079, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3084, '宁夏回族自治区银川市贺兰县', '贺兰县', ',3078,3079,', 3079, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3085, '宁夏回族自治区银川市灵武市', '灵武市', ',3078,3079,', 3079, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3086, '宁夏回族自治区石嘴山市', '石嘴山市', ',3078,', 3078, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3087, '宁夏回族自治区石嘴山市大武口区', '大武口区', ',3078,3086,', 3086, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3088, '宁夏回族自治区石嘴山市惠农区', '惠农区', ',3078,3086,', 3086, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3089, '宁夏回族自治区石嘴山市平罗县', '平罗县', ',3078,3086,', 3086, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3090, '宁夏回族自治区吴忠市', '吴忠市', ',3078,', 3078, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3091, '宁夏回族自治区吴忠市利通区', '利通区', ',3078,3090,', 3090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3092, '宁夏回族自治区吴忠市红寺堡区', '红寺堡区', ',3078,3090,', 3090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3093, '宁夏回族自治区吴忠市盐池县', '盐池县', ',3078,3090,', 3090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3094, '宁夏回族自治区吴忠市同心县', '同心县', ',3078,3090,', 3090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3095, '宁夏回族自治区吴忠市青铜峡市', '青铜峡市', ',3078,3090,', 3090, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3096, '宁夏回族自治区固原市', '固原市', ',3078,', 3078, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3097, '宁夏回族自治区固原市原州区', '原州区', ',3078,3096,', 3096, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3098, '宁夏回族自治区固原市西吉县', '西吉县', ',3078,3096,', 3096, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3099, '宁夏回族自治区固原市隆德县', '隆德县', ',3078,3096,', 3096, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3100, '宁夏回族自治区固原市泾源县', '泾源县', ',3078,3096,', 3096, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3101, '宁夏回族自治区固原市彭阳县', '彭阳县', ',3078,3096,', 3096, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3102, '宁夏回族自治区中卫市', '中卫市', ',3078,', 3078, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3103, '宁夏回族自治区中卫市沙坡头区', '沙坡头区', ',3078,3102,', 3102, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3104, '宁夏回族自治区中卫市中宁县', '中宁县', ',3078,3102,', 3102, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3105, '宁夏回族自治区中卫市海原县', '海原县', ',3078,3102,', 3102, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3106, '新疆维吾尔自治区', '新疆维吾尔自治区', ',', NULL, 30, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3107, '新疆维吾尔自治区乌鲁木齐市', '乌鲁木齐市', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3108, '新疆维吾尔自治区乌鲁木齐市天山区', '天山区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3109, '新疆维吾尔自治区乌鲁木齐市沙依巴克区', '沙依巴克区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3110, '新疆维吾尔自治区乌鲁木齐市新市区', '新市区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3111, '新疆维吾尔自治区乌鲁木齐市水磨沟区', '水磨沟区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3112, '新疆维吾尔自治区乌鲁木齐市头屯河区', '头屯河区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3113, '新疆维吾尔自治区乌鲁木齐市达坂城区', '达坂城区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3114, '新疆维吾尔自治区乌鲁木齐市米东区', '米东区', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3115, '新疆维吾尔自治区乌鲁木齐市乌鲁木齐县', '乌鲁木齐县', ',3106,3107,', 3107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3116, '新疆维吾尔自治区克拉玛依市', '克拉玛依市', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3117, '新疆维吾尔自治区克拉玛依市独山子区', '独山子区', ',3106,3116,', 3116, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3118, '新疆维吾尔自治区克拉玛依市克拉玛依区', '克拉玛依区', ',3106,3116,', 3116, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3119, '新疆维吾尔自治区克拉玛依市白碱滩区', '白碱滩区', ',3106,3116,', 3116, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3120, '新疆维吾尔自治区克拉玛依市乌尔禾区', '乌尔禾区', ',3106,3116,', 3116, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3121, '新疆维吾尔自治区吐鲁番地区', '吐鲁番地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3122, '新疆维吾尔自治区吐鲁番地区吐鲁番市', '吐鲁番市', ',3106,3121,', 3121, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3123, '新疆维吾尔自治区吐鲁番地区鄯善县', '鄯善县', ',3106,3121,', 3121, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3124, '新疆维吾尔自治区吐鲁番地区托克逊县', '托克逊县', ',3106,3121,', 3121, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3125, '新疆维吾尔自治区哈密地区', '哈密地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3126, '新疆维吾尔自治区哈密地区哈密市', '哈密市', ',3106,3125,', 3125, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3127, '新疆维吾尔自治区哈密地区巴里坤哈萨克自治县', '巴里坤哈萨克自治县', ',3106,3125,', 3125, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3128, '新疆维吾尔自治区哈密地区伊吾县', '伊吾县', ',3106,3125,', 3125, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3129, '新疆维吾尔自治区昌吉回族自治州', '昌吉回族自治州', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3130, '新疆维吾尔自治区昌吉回族自治州昌吉市', '昌吉市', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3131, '新疆维吾尔自治区昌吉回族自治州阜康市', '阜康市', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3132, '新疆维吾尔自治区昌吉回族自治州呼图壁县', '呼图壁县', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3133, '新疆维吾尔自治区昌吉回族自治州玛纳斯县', '玛纳斯县', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3134, '新疆维吾尔自治区昌吉回族自治州奇台县', '奇台县', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3135, '新疆维吾尔自治区昌吉回族自治州吉木萨尔县', '吉木萨尔县', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3136, '新疆维吾尔自治区昌吉回族自治州木垒哈萨克自治县', '木垒哈萨克自治县', ',3106,3129,', 3129, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3137, '新疆维吾尔自治区博尔塔拉蒙古自治州', '博尔塔拉蒙古自治州', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3138, '新疆维吾尔自治区博尔塔拉蒙古自治州博乐市', '博乐市', ',3106,3137,', 3137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3139, '新疆维吾尔自治区博尔塔拉蒙古自治州精河县', '精河县', ',3106,3137,', 3137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3140, '新疆维吾尔自治区博尔塔拉蒙古自治州温泉县', '温泉县', ',3106,3137,', 3137, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3141, '新疆维吾尔自治区巴音郭楞蒙古自治州', '巴音郭楞蒙古自治州', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3142, '新疆维吾尔自治区巴音郭楞蒙古自治州库尔勒市', '库尔勒市', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3143, '新疆维吾尔自治区巴音郭楞蒙古自治州轮台县', '轮台县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3144, '新疆维吾尔自治区巴音郭楞蒙古自治州尉犁县', '尉犁县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3145, '新疆维吾尔自治区巴音郭楞蒙古自治州若羌县', '若羌县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3146, '新疆维吾尔自治区巴音郭楞蒙古自治州且末县', '且末县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3147, '新疆维吾尔自治区巴音郭楞蒙古自治州焉耆回族自治县', '焉耆回族自治县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3148, '新疆维吾尔自治区巴音郭楞蒙古自治州和静县', '和静县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3149, '新疆维吾尔自治区巴音郭楞蒙古自治州和硕县', '和硕县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3150, '新疆维吾尔自治区巴音郭楞蒙古自治州博湖县', '博湖县', ',3106,3141,', 3141, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3151, '新疆维吾尔自治区阿克苏地区', '阿克苏地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3152, '新疆维吾尔自治区阿克苏地区阿克苏市', '阿克苏市', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3153, '新疆维吾尔自治区阿克苏地区温宿县', '温宿县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3154, '新疆维吾尔自治区阿克苏地区库车县', '库车县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3155, '新疆维吾尔自治区阿克苏地区沙雅县', '沙雅县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3156, '新疆维吾尔自治区阿克苏地区新和县', '新和县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3157, '新疆维吾尔自治区阿克苏地区拜城县', '拜城县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3158, '新疆维吾尔自治区阿克苏地区乌什县', '乌什县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3159, '新疆维吾尔自治区阿克苏地区阿瓦提县', '阿瓦提县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3160, '新疆维吾尔自治区阿克苏地区柯坪县', '柯坪县', ',3106,3151,', 3151, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3161, '新疆维吾尔自治区克孜勒苏柯尔克孜自治州', '克孜勒苏柯尔克孜自治州', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3162, '新疆维吾尔自治区克孜勒苏柯尔克孜自治州阿图什市', '阿图什市', ',3106,3161,', 3161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3163, '新疆维吾尔自治区克孜勒苏柯尔克孜自治州阿克陶县', '阿克陶县', ',3106,3161,', 3161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3164, '新疆维吾尔自治区克孜勒苏柯尔克孜自治州阿合奇县', '阿合奇县', ',3106,3161,', 3161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3165, '新疆维吾尔自治区克孜勒苏柯尔克孜自治州乌恰县', '乌恰县', ',3106,3161,', 3161, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3166, '新疆维吾尔自治区喀什地区', '喀什地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3167, '新疆维吾尔自治区喀什地区喀什市', '喀什市', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3168, '新疆维吾尔自治区喀什地区疏附县', '疏附县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3169, '新疆维吾尔自治区喀什地区疏勒县', '疏勒县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3170, '新疆维吾尔自治区喀什地区英吉沙县', '英吉沙县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3171, '新疆维吾尔自治区喀什地区泽普县', '泽普县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3172, '新疆维吾尔自治区喀什地区莎车县', '莎车县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3173, '新疆维吾尔自治区喀什地区叶城县', '叶城县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3174, '新疆维吾尔自治区喀什地区麦盖提县', '麦盖提县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3175, '新疆维吾尔自治区喀什地区岳普湖县', '岳普湖县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3176, '新疆维吾尔自治区喀什地区伽师县', '伽师县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3177, '新疆维吾尔自治区喀什地区巴楚县', '巴楚县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3178, '新疆维吾尔自治区喀什地区塔什库尔干塔吉克自治县', '塔什库尔干塔吉克自治县', ',3106,3166,', 3166, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3179, '新疆维吾尔自治区和田地区', '和田地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3180, '新疆维吾尔自治区和田地区和田市', '和田市', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3181, '新疆维吾尔自治区和田地区和田县', '和田县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3182, '新疆维吾尔自治区和田地区墨玉县', '墨玉县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3183, '新疆维吾尔自治区和田地区皮山县', '皮山县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3184, '新疆维吾尔自治区和田地区洛浦县', '洛浦县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3185, '新疆维吾尔自治区和田地区策勒县', '策勒县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3186, '新疆维吾尔自治区和田地区于田县', '于田县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3187, '新疆维吾尔自治区和田地区民丰县', '民丰县', ',3106,3179,', 3179, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3188, '新疆维吾尔自治区伊犁哈萨克自治州', '伊犁哈萨克自治州', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3189, '新疆维吾尔自治区伊犁哈萨克自治州伊宁市', '伊宁市', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3190, '新疆维吾尔自治区伊犁哈萨克自治州奎屯市', '奎屯市', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3191, '新疆维吾尔自治区伊犁哈萨克自治州伊宁县', '伊宁县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3192, '新疆维吾尔自治区伊犁哈萨克自治州察布查尔锡伯自治县', '察布查尔锡伯自治县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3193, '新疆维吾尔自治区伊犁哈萨克自治州霍城县', '霍城县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3194, '新疆维吾尔自治区伊犁哈萨克自治州巩留县', '巩留县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3195, '新疆维吾尔自治区伊犁哈萨克自治州新源县', '新源县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3196, '新疆维吾尔自治区伊犁哈萨克自治州昭苏县', '昭苏县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3197, '新疆维吾尔自治区伊犁哈萨克自治州特克斯县', '特克斯县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3198, '新疆维吾尔自治区伊犁哈萨克自治州尼勒克县', '尼勒克县', ',3106,3188,', 3188, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3199, '新疆维吾尔自治区塔城地区', '塔城地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3200, '新疆维吾尔自治区塔城地区塔城市', '塔城市', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3201, '新疆维吾尔自治区塔城地区乌苏市', '乌苏市', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3202, '新疆维吾尔自治区塔城地区额敏县', '额敏县', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3203, '新疆维吾尔自治区塔城地区沙湾县', '沙湾县', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3204, '新疆维吾尔自治区塔城地区托里县', '托里县', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3205, '新疆维吾尔自治区塔城地区裕民县', '裕民县', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3206, '新疆维吾尔自治区塔城地区和布克赛尔蒙古自治县', '和布克赛尔蒙古自治县', ',3106,3199,', 3199, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3207, '新疆维吾尔自治区阿勒泰地区', '阿勒泰地区', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3208, '新疆维吾尔自治区阿勒泰地区阿勒泰市', '阿勒泰市', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3209, '新疆维吾尔自治区阿勒泰地区布尔津县', '布尔津县', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3210, '新疆维吾尔自治区阿勒泰地区富蕴县', '富蕴县', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3211, '新疆维吾尔自治区阿勒泰地区福海县', '福海县', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3212, '新疆维吾尔自治区阿勒泰地区哈巴河县', '哈巴河县', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3213, '新疆维吾尔自治区阿勒泰地区青河县', '青河县', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3214, '新疆维吾尔自治区阿勒泰地区吉木乃县', '吉木乃县', ',3106,3207,', 3207, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3215, '新疆维吾尔自治区石河子市', '石河子市', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3216, '新疆维吾尔自治区阿拉尔市', '阿拉尔市', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3217, '新疆维吾尔自治区图木舒克市', '图木舒克市', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3218, '新疆维吾尔自治区五家渠市', '五家渠市', ',3106,', 3106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3219, '台湾省', '台湾省', ',', NULL, 31, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3220, '台湾省台北市', '台北市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3221, '台湾省高雄市', '高雄市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3222, '台湾省台南市', '台南市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3223, '台湾省台中市', '台中市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3224, '台湾省金门县', '金门县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3225, '台湾省南投县', '南投县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3226, '台湾省基隆市', '基隆市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3227, '台湾省新竹市', '新竹市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3228, '台湾省嘉义市', '嘉义市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3229, '台湾省新北市', '新北市', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3230, '台湾省宜兰县', '宜兰县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3231, '台湾省新竹县', '新竹县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3232, '台湾省桃园县', '桃园县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3233, '台湾省苗栗县', '苗栗县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3234, '台湾省彰化县', '彰化县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3235, '台湾省嘉义县', '嘉义县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3236, '台湾省云林县', '云林县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3237, '台湾省屏东县', '屏东县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3238, '台湾省台东县', '台东县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3239, '台湾省花莲县', '花莲县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3240, '台湾省澎湖县', '澎湖县', ',3219,', 3219, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3241, '台湾省台北市中正区', '中正区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3242, '台湾省台北市大同区', '大同区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3243, '台湾省台北市中山区', '中山区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3244, '台湾省台北市松山区', '松山区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3245, '台湾省台北市大安区', '大安区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3246, '台湾省台北市万华区', '万华区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3247, '台湾省台北市信义区', '信义区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3248, '台湾省台北市士林区', '士林区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3249, '台湾省台北市北投区', '北投区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3250, '台湾省台北市内湖区', '内湖区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3251, '台湾省台北市南港区', '南港区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3252, '台湾省台北市文山区', '文山区', ',3219,3220,', 3220, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3253, '台湾省嘉义县东区', '东区', ',3219,3235,', 3235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3254, '台湾省嘉义县西区', '西区', ',3219,3235,', 3235, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3255, '台湾省高雄市新兴区', '新兴区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3256, '台湾省高雄市前金区', '前金区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3257, '台湾省高雄市芩雅区', '芩雅区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3258, '台湾省高雄市盐埕区', '盐埕区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3259, '台湾省高雄市鼓山区', '鼓山区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3260, '台湾省高雄市旗津区', '旗津区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3261, '台湾省高雄市前镇区', '前镇区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3262, '台湾省高雄市三民区', '三民区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3263, '台湾省高雄市左营区', '左营区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3264, '台湾省高雄市楠梓区', '楠梓区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3265, '台湾省高雄市小港区', '小港区', ',3219,3221,', 3221, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3266, '台湾省基隆市仁爱区', '仁爱区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3267, '台湾省基隆市信义区', '信义区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3268, '台湾省基隆市中正区', '中正区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3269, '台湾省基隆市中山区', '中山区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3270, '台湾省基隆市安乐区', '安乐区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3271, '台湾省基隆市暖暖区', '暖暖区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3272, '台湾省基隆市七堵区', '七堵区', ',3219,3226,', 3226, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3273, '台湾省台南市中西区', '中西区', ',3219,3222,', 3222, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3274, '台湾省台南市东区', '东区', ',3219,3222,', 3222, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3275, '台湾省台南市南区', '南区', ',3219,3222,', 3222, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3276, '台湾省台南市北区', '北区', ',3219,3222,', 3222, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3277, '台湾省台南市安平区', '安平区', ',3219,3222,', 3222, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3278, '台湾省台南市安南区', '安南区', ',3219,3222,', 3222, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3279, '台湾省新竹市东区', '东区', ',3219,3227,', 3227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3280, '台湾省新竹市北区', '北区', ',3219,3227,', 3227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3281, '台湾省新竹市香山区', '香山区', ',3219,3227,', 3227, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3282, '台湾省台中市中区', '中区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3283, '台湾省台中市东区', '东区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3284, '台湾省台中市南区', '南区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3285, '台湾省台中市西区', '西区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3286, '台湾省台中市北区', '北区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3287, '台湾省台中市北屯区', '北屯区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3288, '台湾省台中市西屯区', '西屯区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3289, '台湾省台中市南屯区', '南屯区', ',3219,3223,', 3223, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3290, '台湾省嘉义市东区', '东区', ',3219,3228,', 3228, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3291, '台湾省嘉义市西区', '西区', ',3219,3228,', 3228, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3292, '香港特别行政区', '香港特别行政区', ',', NULL, 32, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3293, '香港特别行政区香港岛', '香港岛', ',3292,', 3292, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3294, '香港特别行政区九龙', '九龙', ',3292,', 3292, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3295, '香港特别行政区新界', '新界', ',3292,', 3292, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3296, '香港特别行政区九龙九龙城区', '九龙城区', ',3292,3294,', 3294, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3297, '香港特别行政区九龙油尖旺区', '油尖旺区', ',3292,3294,', 3294, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3298, '香港特别行政区九龙深水埗区', '深水埗区', ',3292,3294,', 3294, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3299, '香港特别行政区九龙黄大仙区', '黄大仙区', ',3292,3294,', 3294, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3300, '香港特别行政区九龙观塘区', '观塘区', ',3292,3294,', 3294, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3301, '香港特别行政区香港岛中西区', '中西区', ',3292,3293,', 3293, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3302, '香港特别行政区香港岛湾仔', '湾仔', ',3292,3293,', 3293, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3303, '香港特别行政区香港岛东区', '东区', ',3292,3293,', 3293, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3304, '香港特别行政区香港岛南区', '南区', ',3292,3293,', 3293, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3305, '香港特别行政区新界北区', '北区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3306, '香港特别行政区新界大埔区', '大埔区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3307, '香港特别行政区新界沙田区', '沙田区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3308, '香港特别行政区新界西贡区', '西贡区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3309, '香港特别行政区新界元朗区', '元朗区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3310, '香港特别行政区新界屯门区', '屯门区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3311, '香港特别行政区新界荃湾区', '荃湾区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3312, '香港特别行政区新界葵青区', '葵青区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3313, '香港特别行政区新界离岛区', '离岛区', ',3292,3295,', 3295, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3314, '澳门特别行政区', '澳门特别行政区', ',', NULL, 33, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3315, '澳门特别行政区澳门半岛', '澳门半岛', ',3314,', 3314, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3316, '澳门特别行政区离岛', '离岛', ',3314,', 3314, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `area` VALUES (3337, '', '测试', ',', 0, 34, 'yangcheng', '2020-09-09 11:09:48', 'yangcheng', '2020-09-09 11:09:56', 0);
INSERT INTO `area` VALUES (3346, '测试1', '测试1', ',3337,', 3337, 0, 'yangcheng', '2020-09-09 11:27:07', 'yangcheng', '2020-09-09 14:36:44', 1);
INSERT INTO `area` VALUES (3347, '测试2', '测试2', ',3337,', 3337, 0, 'yangcheng', '2020-09-09 11:27:56', 'yangcheng', '2020-09-09 14:12:25', 0);
INSERT INTO `area` VALUES (3348, '测试1测试11', '测试11', ',3337,3346,', 3346, 0, 'yangcheng', '2020-09-09 11:28:02', 'yangcheng', '2020-09-09 14:36:44', 1);
INSERT INTO `area` VALUES (3349, '测试1测试12', '测试12', ',3337,3346,', 3346, 0, 'yangcheng', '2020-09-09 11:28:07', 'yangcheng', '2020-09-09 14:36:44', 1);
INSERT INTO `area` VALUES (3350, '测试3', '测试3', ',3337,', 3337, 0, 'yangcheng', '2020-09-09 11:58:32', '', '2020-09-09 11:58:32', 0);
INSERT INTO `area` VALUES (3351, '测试1测试13', '测试13', ',3337,3346,', 3346, 0, 'yangcheng', '2020-09-09 11:58:39', 'yangcheng', '2020-09-09 14:36:44', 1);
INSERT INTO `area` VALUES (3352, '测试2测试22', '测试22', ',3337,3347,', 3347, 0, 'yangcheng', '2020-09-09 14:11:15', 'yangcheng', '2020-09-09 14:12:25', 0);
INSERT INTO `area` VALUES (3353, '测试2测试22测试222', '测试222', ',3337,3347,3352,', 3352, 0, 'yangcheng', '2020-09-09 14:11:21', '', '2020-09-09 14:11:21', 0);

-- ----------------------------
-- Table structure for area_freight_config
-- ----------------------------
DROP TABLE IF EXISTS `area_freight_config`;
CREATE TABLE `area_freight_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_ID',
  `first_price` decimal(21, 6) NOT NULL COMMENT '首重价格',
  `continue_price` decimal(21, 6) NOT NULL COMMENT '续重价格',
  `shipping_method_id` bigint(20) NOT NULL COMMENT '配送方式',
  `area_id` bigint(20) NOT NULL COMMENT '地区',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NULL DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shipping_method_id`(`shipping_method_id`) USING BTREE,
  INDEX `area_id`(`area_id`) USING BTREE,
  CONSTRAINT `area_freight_config_ibfk_1` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_method` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `area_freight_config_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of area_freight_config
-- ----------------------------

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `seo_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面标题',
  `seo_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面描述',
  `seo_keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面关键词',
  `is_publication` tinyint(1) NOT NULL COMMENT '是否发布',
  `is_top` tinyint(1) NOT NULL COMMENT '是否置顶',
  `hits` bigint(20) NOT NULL COMMENT '点击数',
  `article_category_id` bigint(20) NOT NULL COMMENT '文章分类',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK636982B7CA3B1F7`(`article_category_id`) USING BTREE,
  CONSTRAINT `FK636982B7CA3B1F7` FOREIGN KEY (`article_category_id`) REFERENCES `article_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `seo_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面标题',
  `seo_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面描述',
  `seo_keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面关键词',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级分类',
  `grade` int(11) NULL DEFAULT NULL COMMENT '层级',
  `tree_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树路径',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK57108986F587647A`(`parent_id`) USING BTREE,
  CONSTRAINT `FK57108986F587647A` FOREIGN KEY (`parent_id`) REFERENCES `article_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of article_category
-- ----------------------------

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag`  (
  `articles` bigint(20) NOT NULL,
  `tags` bigint(20) NOT NULL,
  PRIMARY KEY (`articles`, `tags`) USING BTREE,
  INDEX `FKB9183E12C842716F`(`tags`) USING BTREE,
  INDEX `FKB9183E1229F6DEEF`(`articles`) USING BTREE,
  CONSTRAINT `FKB9183E1229F6DEEF` FOREIGN KEY (`articles`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKB9183E12C842716F` FOREIGN KEY (`tags`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of article_tag
-- ----------------------------

-- ----------------------------
-- Table structure for attribute
-- ----------------------------
DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `property_index` int(11) NULL DEFAULT NULL COMMENT '属性序号',
  `product_category_id` bigint(20) NOT NULL COMMENT '绑定分类',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKE81F41DD7629117`(`product_category_id`) USING BTREE,
  CONSTRAINT `FKE81F41DD7629117` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '属性' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attribute
-- ----------------------------

-- ----------------------------
-- Table structure for attribute_option
-- ----------------------------
DROP TABLE IF EXISTS `attribute_option`;
CREATE TABLE `attribute_option`  (
  `attribute` bigint(20) NOT NULL,
  `options` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '可选项',
  INDEX `FK96E026D75E1B95F4`(`attribute`) USING BTREE,
  CONSTRAINT `FK96E026D75E1B95F4` FOREIGN KEY (`attribute`) REFERENCES `attribute` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attribute_option
-- ----------------------------

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `type` int(11) NOT NULL COMMENT '类型',
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '介绍',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'logo',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品牌' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (25, '爱士图尔庄园', 0, '', '', '', 0, '管理员', '2021-01-22 11:53:29', '', '2021-01-22 11:53:29', 0);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `cart_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密钥',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9E1A84FF7C62EDF8`(`member_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 985 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (892, 510, '118cacc5-52f3-4987-ae6c-3e96b03a8b9d-3cd471ba82c400398b54ba6b385fa0b7', '18148789239', '2021-01-26 15:03:29', '', '2021-01-26 15:03:29', 0);
INSERT INTO `cart` VALUES (893, 510, 'a4cc8da0-3a0a-470c-883b-40ba5c8d97ce-fa1a76d512d08f734ce3bfae19422ea3', '18148789239', '2021-01-26 15:24:35', '', '2021-01-26 15:24:35', 0);
INSERT INTO `cart` VALUES (894, 510, 'cc5a5a77-4f85-410b-8adc-f428beea488d-d62dc15261bd9e5408fad5356a51990a', '18148789239', '2021-01-26 15:24:49', '', '2021-01-26 15:24:49', 0);
INSERT INTO `cart` VALUES (895, 510, 'db99b7e2-1882-4ed9-8f4a-c5641632365f-999fb83aeaa7f0d39548b758bf20bc24', '18148789239', '2021-01-26 15:25:30', '', '2021-01-26 15:25:30', 0);
INSERT INTO `cart` VALUES (896, 510, '4dc2d89e-0a34-4a78-8b9a-91c4dff23392-f6360a78a64c2d90b9f46e2c4a86bb96', '18148789239', '2021-01-26 15:25:57', '', '2021-01-26 15:25:57', 0);
INSERT INTO `cart` VALUES (897, 510, 'cd55071b-9d8d-45ec-a0ae-cd090e4be567-c29171a70a6748e32b5239194df6edd1', '18148789239', '2021-01-26 15:26:38', '', '2021-01-26 15:26:38', 0);
INSERT INTO `cart` VALUES (898, 510, '65dfe996-2cc8-44f6-ae02-a9d7e4bd63f2-ba83714f5c62493466850604c389125b', '18148789239', '2021-01-26 15:47:41', '', '2021-01-26 15:47:41', 0);
INSERT INTO `cart` VALUES (899, 510, 'c6b80713-3ca8-4220-82e7-1954734ca09b-d201468908dec9cfa1279f65b1cda3c7', '18148789239', '2021-01-26 15:48:29', '', '2021-01-26 15:48:29', 0);
INSERT INTO `cart` VALUES (900, 510, '5dfa0dd3-85e3-48d3-8239-315a5595a56f-e332b75f4128c485fbf841b3000aed5b', '18148789239', '2021-01-26 15:50:04', '', '2021-01-26 15:50:04', 0);
INSERT INTO `cart` VALUES (901, 510, '7fd9ddf2-a350-4d38-8350-85e21ea8f00a-e8b4b899215f100f457aea845ff318fc', '18148789239', '2021-01-26 15:52:39', '', '2021-01-26 15:52:39', 0);
INSERT INTO `cart` VALUES (902, 510, 'c06eb181-df6f-4187-a569-25cc066ebf60-37013ee2b8714930ee7254e441892314', '18148789239', '2021-01-26 16:21:42', '', '2021-01-26 16:21:42', 0);
INSERT INTO `cart` VALUES (903, 510, '42c840cb-b1bf-4583-a708-3a46fe973cda-5e55112423052611e6de63739b1f4a8e', '18148789239', '2021-01-26 16:24:24', '', '2021-01-26 16:24:24', 0);
INSERT INTO `cart` VALUES (904, 510, '9d9e00b9-5a4d-4c3f-83a2-4ded1fbc9d4e-c80f2d12a56c89d24abfa251fa73d4ae', '18148789239', '2021-01-26 16:24:46', '', '2021-01-26 16:24:46', 0);
INSERT INTO `cart` VALUES (905, 510, '0ebf84b7-dfe0-4d39-803d-80a987426d2d-63d72d2d40310621b14ccf9bfea09f86', '18148789239', '2021-01-26 16:25:37', '', '2021-01-26 16:25:37', 0);
INSERT INTO `cart` VALUES (906, 510, 'a90a0aac-a27f-4ca3-bdd3-f62f6f74cc22-b2d2a2113cbb527ea43556142baf7ae6', '18148789239', '2021-01-26 16:26:13', '', '2021-01-26 16:26:13', 0);
INSERT INTO `cart` VALUES (907, 510, '60c83109-f160-4c33-9fdc-d9750dd9e6f4-0d5af2c35b8635535ecab9bd50755576', '18148789239', '2021-01-26 16:30:59', '', '2021-01-26 16:30:59', 0);
INSERT INTO `cart` VALUES (908, 510, '708a474f-0a4a-4c38-826e-fafe9a61b5d8-c67e7af18422227b3a0b78a2c1faa139', '18148789239', '2021-01-26 16:31:46', '', '2021-01-26 16:31:46', 0);
INSERT INTO `cart` VALUES (913, 510, 'eae73a14-fc05-47e5-8182-143f4f25fbd8-eecd2ca7ac793cd70758703d87d23988', '', '2021-02-22 11:16:35', '', '2021-02-22 11:16:35', 0);
INSERT INTO `cart` VALUES (914, 510, '7879ad69-1e60-4320-91ba-398041d22126-a06d1ae6b05ddccc065c65143a724752', '', '2021-02-22 15:11:46', '', '2021-02-22 15:11:46', 0);
INSERT INTO `cart` VALUES (915, 510, 'a28e7dab-670a-4759-b6b5-9c39bf8aab0a-b95409e2c764efd1e3d010439cfb2266', '18148789239', '2021-03-01 09:56:45', '', '2021-03-01 09:56:45', 0);
INSERT INTO `cart` VALUES (916, 510, '36a85d04-9400-4e2e-bae3-bbee93e003ab-400b9756ab15909a96770c02b24af6c6', '18148789239', '2021-03-01 10:09:39', '', '2021-03-01 10:09:39', 0);
INSERT INTO `cart` VALUES (917, 510, 'a7cbaccd-8da5-4fec-824b-6bf5d87d0aa1-06069f16f7ddf46ed4dcc861e9b8821f', '', '2021-03-01 10:40:09', '', '2021-03-01 10:40:09', 0);
INSERT INTO `cart` VALUES (918, 510, 'f1a82988-fa8a-44a2-a297-b6869aaf3e4d-6aa938718dc027e687651700cba6f272', '18148789239', '2021-03-01 10:44:31', '', '2021-03-01 10:44:31', 0);
INSERT INTO `cart` VALUES (919, 510, 'b2f94f99-95bb-4dbb-90e8-a45bb8e14b4c-365b1723008a75297844e73b65c5920a', '', '2021-03-01 10:44:32', '', '2021-03-01 10:44:32', 0);
INSERT INTO `cart` VALUES (920, 510, '9e05a2c6-e834-41ca-846e-0f9a9b79d20d-c0f1d366ca212a3d26590b53bd242ae5', '18148789239', '2021-03-01 10:45:54', '', '2021-03-01 10:45:54', 0);
INSERT INTO `cart` VALUES (921, 510, 'd8a3d273-552c-4c14-a422-7a2a4db97ac2-cfcc0e020ae2bb5331f6396e731999c3', '18148789239', '2021-03-01 10:46:36', '', '2021-03-01 10:46:36', 0);
INSERT INTO `cart` VALUES (922, 510, 'f5c7592f-f9ef-41e0-8a43-31a0fd216f59-0bf224a51ca2d67846930ea3b6d401ad', '18148789239', '2021-03-01 10:48:10', '', '2021-03-01 10:48:10', 0);
INSERT INTO `cart` VALUES (923, 510, 'f0b9e5e5-7f8e-4d15-9c40-ba7136e69f08-b75c16a8927d84a184a4996d455d4814', '18148789239', '2021-03-01 11:01:15', '', '2021-03-01 11:01:15', 0);
INSERT INTO `cart` VALUES (924, 510, 'e2923719-688c-423d-aa67-b264179b90ee-65d3470b45b43a42257e402b76656008', '18148789239', '2021-03-01 14:57:25', '', '2021-03-01 14:57:25', 0);
INSERT INTO `cart` VALUES (925, 512, '8eb4cb1d-926e-48e0-b053-449850c9d827-9c0e123530d85ef1ab2d67fea824bd9c', '', '2021-03-01 17:09:56', '', '2021-03-01 17:09:56', 0);
INSERT INTO `cart` VALUES (926, 512, '220f555e-511d-4582-ba3c-b43d085caa11-6ee5a2e561f1a7caf4d3eb30619fd7e4', '', '2021-03-01 17:14:59', '', '2021-03-01 17:14:59', 0);
INSERT INTO `cart` VALUES (927, 510, 'd7de39a9-2975-4e2d-9c80-1d90befde189-50d05b9e013fb0075a5b831aa3058c86', '18148789239', '2021-03-01 17:59:05', '', '2021-03-01 17:59:05', 0);
INSERT INTO `cart` VALUES (928, 510, '87bd848b-fa29-4f66-8526-b798263df954-72e0d3df3cf8006955ffaa4d2c0dd655', '18148789239', '2021-03-01 18:08:08', '', '2021-03-01 18:08:08', 0);
INSERT INTO `cart` VALUES (929, 510, '72f1ca6b-ee36-446c-bdd6-b2be582a2b9b-eb255429c554557c13ceb3b7504a7b3c', '18148789239', '2021-03-02 08:40:33', '', '2021-03-02 08:40:33', 0);
INSERT INTO `cart` VALUES (930, 510, '062043f1-f7d0-4ca2-9f62-8bb9451b4179-1106a02873aa1b4a1b33817bc2f83940', '18148789239', '2021-03-02 08:52:41', '', '2021-03-02 08:52:41', 0);
INSERT INTO `cart` VALUES (931, 510, 'd9ef0edf-7ac5-49c8-bb31-4d15ce705ee9-615642d7ffa7503362ba54c020187f11', '18148789239', '2021-03-02 15:41:02', '', '2021-03-02 15:41:02', 0);
INSERT INTO `cart` VALUES (932, 510, '0c4be2e1-0811-4277-9245-90b65453fe01-d5ff793927c66794ccd388799e53a4d4', '18148789239', '2021-03-02 16:09:30', '', '2021-03-02 16:09:30', 0);
INSERT INTO `cart` VALUES (933, 510, 'b40bf5df-bcdd-4b91-9470-e953a36846f9-01da4bda4c82e80b0d233ca17923ad97', '18148789239', '2021-03-02 16:25:21', '', '2021-03-02 16:25:21', 0);
INSERT INTO `cart` VALUES (934, 510, '84e0c68a-ad3a-4005-9268-41049c554c62-56af058a9dea1da47ad70acc92ad66b3', '18148789239', '2021-03-02 16:39:31', '', '2021-03-02 16:39:31', 0);
INSERT INTO `cart` VALUES (935, 510, '32e98d7e-9021-4174-806a-4f4c8a884e0d-2a9db806414a5109be6c6ab488d1d8c0', '18148789239', '2021-03-02 16:46:33', '', '2021-03-02 16:46:33', 0);
INSERT INTO `cart` VALUES (936, 510, 'affc9e3a-f042-42da-9a31-1c656beb51bb-d2d78584dc17582e18709e5188dcc5c8', '18148789239', '2021-03-02 16:48:17', '', '2021-03-02 16:48:17', 0);
INSERT INTO `cart` VALUES (937, 510, '63eaa556-0e70-4fa5-a615-bc0a6d70c7fa-f49063b08c72d51967cc77d229bdb83b', '18148789239', '2021-03-02 16:52:46', '', '2021-03-02 16:52:46', 0);
INSERT INTO `cart` VALUES (938, 510, 'ce4bfff0-e1db-414f-9820-69cccf552153-892a24e61b21905398593aac654cac9e', '18148789239', '2021-03-02 17:04:17', '', '2021-03-02 17:04:17', 0);
INSERT INTO `cart` VALUES (939, 510, 'c52a5c4a-4a5c-42ba-ab21-684413c4b6f7-95313688b3ae4a3c9a64b90b1dbec546', '18148789239', '2021-03-02 17:06:11', '', '2021-03-02 17:06:11', 0);
INSERT INTO `cart` VALUES (940, 510, '3eaec2b6-a396-42e4-9a03-331ae788ddd4-bca3d454c8c654206f70810a9f605ae5', '18148789239', '2021-03-02 17:10:59', '', '2021-03-02 17:10:59', 0);
INSERT INTO `cart` VALUES (941, 510, '059b730c-84e9-4233-8fc0-ed40ee7c0bed-b54b5e1ed823b67c15ff331c0370885d', '18148789239', '2021-03-02 17:12:04', '', '2021-03-02 17:12:04', 0);
INSERT INTO `cart` VALUES (942, 510, '1f282abb-bdf7-46d0-a4ed-69b639160d7c-d194578bfb93ac5d4bfae571a26e29c3', '18148789239', '2021-03-02 17:19:19', '', '2021-03-02 17:19:19', 0);
INSERT INTO `cart` VALUES (943, 510, '2815d14d-b23a-4a4e-b173-46be52764980-9895470e0891343960a5f0522bc8bcb1', '18148789239', '2021-03-02 17:25:59', '', '2021-03-02 17:25:59', 0);
INSERT INTO `cart` VALUES (944, 510, 'ac0327e9-3db4-4b6f-80f8-880bd80425e7-a97362b55580b890e2e0f31e294fdb1a', '18148789239', '2021-03-02 17:49:04', '', '2021-03-02 17:49:04', 0);
INSERT INTO `cart` VALUES (945, 510, '89dfb10e-52db-46cf-b6e8-df0894491592-af5173c0f546414c4a3bb407ec01895f', '18148789239', '2021-03-02 17:52:34', '', '2021-03-02 17:52:34', 0);
INSERT INTO `cart` VALUES (946, 510, '4fb270ff-7fdc-4091-a898-e66ba132d1e7-9212a6639bee384f95c9c155e3b957c2', '18148789239', '2021-03-02 17:59:12', '', '2021-03-02 17:59:12', 0);
INSERT INTO `cart` VALUES (947, 510, '9aeae4f4-a8dc-4fe0-8662-7ea899249739-7dcedf10ffce5aea63f68a6efae6f91a', '18148789239', '2021-03-02 18:03:07', '', '2021-03-02 18:03:07', 0);
INSERT INTO `cart` VALUES (948, 510, '792720a3-1b4c-42f5-9de4-10a61accd9fd-cc15d03f16525bb4a9837bf639887425', '18148789239', '2021-03-02 18:10:13', '', '2021-03-02 18:10:13', 0);
INSERT INTO `cart` VALUES (949, 510, 'e066f126-1e08-4001-9f69-b7c549a307bd-2e1b767fa03520876db6fd977f3d4555', '18148789239', '2021-03-02 18:12:15', '', '2021-03-02 18:12:15', 0);
INSERT INTO `cart` VALUES (950, 510, 'cb02862c-2cc6-49b0-9e0c-d32bc5ea119a-0bc351ff66ebfd59448fa87d84aa5811', '18148789239', '2021-03-02 18:15:23', '', '2021-03-02 18:15:23', 0);
INSERT INTO `cart` VALUES (951, 510, '30585b81-d350-49e9-84e3-344b54bb718a-fe28836dad6e37c272bb97899d6f1dd1', '18148789239', '2021-03-02 18:17:02', '', '2021-03-02 18:17:02', 0);
INSERT INTO `cart` VALUES (952, 510, '7e809267-b1c8-4bf9-819d-af138ce5dbaa-fef59853e8476b4083cc1f8207f91f15', '18148789239', '2021-03-02 18:18:30', '', '2021-03-02 18:18:30', 0);
INSERT INTO `cart` VALUES (953, 510, 'ba857b1c-3e2b-4bc3-878c-e53bab7b4a4e-d99696f8cdc78213230db69b3bf6de39', '18148789239', '2021-03-02 18:21:28', '', '2021-03-02 18:21:28', 0);
INSERT INTO `cart` VALUES (954, 510, '8e6ca948-6f3c-42bf-a4e0-914c72dde638-f3e206d69046d4baf2a83d79b461869b', '18148789239', '2021-03-02 22:44:14', '', '2021-03-02 22:44:14', 0);
INSERT INTO `cart` VALUES (955, 510, '390fd0dc-128b-4235-8371-39dedb31c36b-25f860f066cd3417903eeca4bdd66925', '18148789239', '2021-03-02 22:44:53', '', '2021-03-02 22:44:53', 0);
INSERT INTO `cart` VALUES (956, 510, '156f7531-ba5e-4fa0-9796-98384d704ecf-385493e6f0f00ae4460d31b4a7989953', '18148789239', '2021-03-03 09:11:48', '', '2021-03-03 09:11:48', 0);
INSERT INTO `cart` VALUES (957, 510, 'feff3a5e-30b3-4b7b-805c-05397e912cc0-f0e4b156f8c4a02526adda58c17fddc0', '18148789239', '2021-03-03 09:20:44', '', '2021-03-03 09:20:44', 0);
INSERT INTO `cart` VALUES (958, 510, 'c252eb52-39c1-46ec-a0d3-b0343683c43a-07b55561fa31f7de5ba7106a1d9d3ae5', '18148789239', '2021-03-03 09:46:48', '', '2021-03-03 09:46:48', 0);
INSERT INTO `cart` VALUES (959, 510, '52cb76ee-1cc8-4e64-b6b0-092d8776d6a6-d9d1b2df9819f32dc19718ebe2c74d12', '18148789239', '2021-03-03 15:41:57', '', '2021-03-03 15:41:57', 0);
INSERT INTO `cart` VALUES (960, 510, 'a5a2ece1-25de-4a66-84f9-1bc1bf96e7b3-62287e8b4d008f7884c899f5734b6cf1', '18148789239', '2021-03-03 15:42:26', '', '2021-03-03 15:42:26', 0);
INSERT INTO `cart` VALUES (961, 510, '3598a639-0270-416e-93aa-43cea1ed4253-10f1a36dd152693eb6663b7419a68445', '18148789239', '2021-03-03 15:46:08', '', '2021-03-03 15:46:08', 0);
INSERT INTO `cart` VALUES (962, 510, 'f01c1da8-2362-4fd8-b403-a43a5aafb076-a7a5ca5397d8a4c211b570bbd74e8cc5', '18148789239', '2021-03-03 15:46:38', '', '2021-03-03 15:46:38', 0);
INSERT INTO `cart` VALUES (963, 510, '2dabc2a2-609c-4916-aa68-47748494369a-72dfe03d4e5a5b268d9de86ade63135b', '18148789239', '2021-03-03 15:52:05', '', '2021-03-03 15:52:05', 0);
INSERT INTO `cart` VALUES (964, 510, '86a40fc4-a3bb-4638-939c-c0c2e310ab2c-2864ada1a138f067895c10c3fa8c5a65', '18148789239', '2021-03-03 16:01:26', '', '2021-03-03 16:01:26', 0);
INSERT INTO `cart` VALUES (965, 510, 'dc5188fb-50fa-4cc7-b9db-873ccb9adbf1-0913465565cf5a0554afa7017289cf4e', '18148789239', '2021-03-03 16:04:08', '', '2021-03-03 16:04:08', 0);
INSERT INTO `cart` VALUES (966, 510, '61d38d6f-5207-4f2b-943c-95030aae1df3-2ef484ea56b16d5908bd7afed7a9ea6c', '18148789239', '2021-03-04 14:10:23', '', '2021-03-04 14:10:23', 0);
INSERT INTO `cart` VALUES (967, 510, 'f6f567e7-5b57-4d79-9b82-92f1f4c927a3-02aac99d3f0f75f7bdcc4d030d9caf25', '18148789239', '2021-03-04 14:14:02', '', '2021-03-04 14:14:02', 0);
INSERT INTO `cart` VALUES (968, 510, '049b98a5-a6eb-437f-89aa-c7e56d904847-b8ffe557e132693bad2d12ed8840516b', '18148789239', '2021-03-04 14:15:48', '', '2021-03-04 14:15:48', 0);
INSERT INTO `cart` VALUES (969, 510, '0a4cde18-a91f-46a7-8dee-b43837e85bca-af895b5d14ebd438181f289b477d95cd', '18148789239', '2021-03-04 14:22:45', '', '2021-03-04 14:22:45', 0);
INSERT INTO `cart` VALUES (970, 510, 'e2810820-939c-4741-a963-c9a90e48375b-6ef111d326e04efb711c3edc47d9af6e', '18148789239', '2021-03-04 14:26:36', '', '2021-03-04 14:26:36', 0);
INSERT INTO `cart` VALUES (971, 510, '11528e07-4133-408f-b854-61fa51f4568e-7389bb11f3714d4eb7f428be1b1d5099', '18148789239', '2021-03-04 14:33:29', '', '2021-03-04 14:33:29', 0);
INSERT INTO `cart` VALUES (972, 510, 'ec9eef0f-b962-4845-af83-6346da8d896d-1cbf6d9292d28117dd7daccdfbde0bb0', '18148789239', '2021-03-04 14:41:09', '', '2021-03-04 14:41:09', 0);
INSERT INTO `cart` VALUES (973, 510, 'd809ea41-25fb-4a75-9fcc-df2cb879c210-c2a136e439c02dc4cec52c92bae5fd78', '18148789239', '2021-03-04 14:58:37', '', '2021-03-04 14:58:37', 0);
INSERT INTO `cart` VALUES (974, 510, '92157c64-704a-4fee-90cc-10cea42cde68-a248ac12ab891bec3dacd685ad4d108e', '18148789239', '2021-03-04 15:01:56', '', '2021-03-04 15:01:56', 0);
INSERT INTO `cart` VALUES (975, 510, 'b984b8ff-9895-42ea-a956-52cd8078d4c2-0a23b1715f9c0a634acc824122746a44', '18148789239', '2021-03-04 15:11:21', '', '2021-03-04 15:11:21', 0);
INSERT INTO `cart` VALUES (976, 510, '5fa1c1c7-634d-47ae-9abc-e74f72639e05-19a715b2b847fd3bdc44a35870326fed', '18148789239', '2021-03-04 16:14:15', '', '2021-03-04 16:14:15', 0);
INSERT INTO `cart` VALUES (977, 510, '560b93f0-44c7-4545-89c3-5664ca933d9f-cccbd0c833484e8d9e04d870140bff54', '18148789239', '2021-03-10 10:02:33', '', '2021-03-10 10:02:33', 0);
INSERT INTO `cart` VALUES (978, 510, 'e813fbaf-eb9f-4d45-8701-8bd3f649e73f-46bc8a105619fb8bc248c863e34e415a', '18148789239', '2021-03-10 10:56:06', '', '2021-03-10 10:56:06', 0);
INSERT INTO `cart` VALUES (979, 510, 'bd7891d1-045c-4c83-b9bf-512c190cee00-10715b429508b28baba2414abafe3e9c', '18148789239', '2021-03-10 11:04:26', '', '2021-03-10 11:04:26', 0);
INSERT INTO `cart` VALUES (980, 510, '1a35212e-a4d7-4135-9b20-f305897fdedb-3039ae3b00b24ed87c130fdafe040deb', '18148789239', '2021-03-10 11:10:41', '', '2021-03-10 11:10:41', 0);
INSERT INTO `cart` VALUES (981, 510, '4359dc3b-f310-477b-8426-19f5c8f80c49-383e39df8921cdd50cba3c7bcb5d2a0f', '18148789239', '2021-03-10 11:12:09', '', '2021-03-10 11:12:09', 0);
INSERT INTO `cart` VALUES (982, 510, 'bed47996-e067-443a-a6c3-9752ab74d5c4-25a9f68dd7ad55b0fa53fa4fd11f4f40', '18148789239', '2021-03-10 11:13:37', '', '2021-03-10 11:13:37', 0);
INSERT INTO `cart` VALUES (983, 510, '3a1aeafd-b940-4560-a6ed-0b205080c42a-3ab452f87e995197bdfd6f15744e99e0', '18148789239', '2021-03-10 11:20:25', '', '2021-03-10 11:20:25', 0);
INSERT INTO `cart` VALUES (984, 510, '0ff09f3e-b507-4626-b1d4-929b620a74cf-e8f2ec95556cb782a5b92493a9ae5cd7', '18148789239', '2021-03-10 15:28:21', '', '2021-03-10 15:28:21', 0);

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `cart_id` bigint(20) NOT NULL COMMENT '购物车',
  `sku_id` bigint(20) NOT NULL COMMENT 'SKU',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK1A67F65339A23004`(`cart_id`) USING BTREE,
  INDEX `FK1A67F65379F8D99A`(`sku_id`) USING BTREE,
  CONSTRAINT `FK1A67F65339A23004` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1786 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车项' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart_item
-- ----------------------------
INSERT INTO `cart_item` VALUES (1709, 897, 185, 3, '18148789239', '2021-01-26 15:26:38', '', '2021-01-26 16:35:02', 0);
INSERT INTO `cart_item` VALUES (1710, 898, 185, 1, '18148789239', '2021-01-26 15:47:41', '', '2021-01-26 15:47:41', 0);
INSERT INTO `cart_item` VALUES (1711, 899, 185, 1, '18148789239', '2021-01-26 15:48:29', '', '2021-01-26 15:48:29', 0);
INSERT INTO `cart_item` VALUES (1712, 900, 185, 1, '18148789239', '2021-01-26 15:50:04', '', '2021-01-26 15:50:04', 0);
INSERT INTO `cart_item` VALUES (1713, 901, 185, 1, '18148789239', '2021-01-26 15:52:39', '', '2021-01-26 15:52:39', 0);
INSERT INTO `cart_item` VALUES (1714, 902, 185, 1, '18148789239', '2021-01-26 16:21:42', '', '2021-01-26 16:21:42', 0);
INSERT INTO `cart_item` VALUES (1715, 903, 185, 1, '18148789239', '2021-01-26 16:24:24', '', '2021-01-26 16:24:24', 0);
INSERT INTO `cart_item` VALUES (1716, 904, 185, 1, '18148789239', '2021-01-26 16:24:46', '', '2021-01-26 16:24:46', 0);
INSERT INTO `cart_item` VALUES (1717, 905, 185, 1, '18148789239', '2021-01-26 16:25:38', '', '2021-01-26 16:25:38', 0);
INSERT INTO `cart_item` VALUES (1718, 906, 185, 1, '18148789239', '2021-01-26 16:26:13', '', '2021-01-26 16:26:13', 0);
INSERT INTO `cart_item` VALUES (1719, 907, 185, 1, '18148789239', '2021-01-26 16:30:59', '', '2021-01-26 16:30:59', 0);
INSERT INTO `cart_item` VALUES (1720, 908, 185, 1, '18148789239', '2021-01-26 16:31:46', '', '2021-01-26 16:31:46', 0);
INSERT INTO `cart_item` VALUES (1721, 913, 188, 5, '', '2021-02-22 11:16:35', '', '2021-02-24 15:39:41', 1);
INSERT INTO `cart_item` VALUES (1723, 914, 188, 1, '', '2021-02-22 15:11:46', '', '2021-02-22 15:11:46', 0);
INSERT INTO `cart_item` VALUES (1724, 915, 188, 1, '18148789239', '2021-03-01 09:56:45', '', '2021-03-01 09:56:45', 0);
INSERT INTO `cart_item` VALUES (1725, 916, 188, 1, '18148789239', '2021-03-01 10:09:39', '', '2021-03-01 10:09:39', 0);
INSERT INTO `cart_item` VALUES (1726, 918, 188, 1, '18148789239', '2021-03-01 10:44:31', '', '2021-03-01 10:44:31', 0);
INSERT INTO `cart_item` VALUES (1728, 920, 188, 1, '18148789239', '2021-03-01 10:45:54', '', '2021-03-01 10:45:54', 0);
INSERT INTO `cart_item` VALUES (1734, 924, 188, 1, '18148789239', '2021-03-01 14:57:25', '', '2021-03-01 14:57:25', 0);
INSERT INTO `cart_item` VALUES (1736, 925, 188, 1, '', '2021-03-01 17:09:56', '', '2021-03-01 17:09:56', 0);
INSERT INTO `cart_item` VALUES (1737, 926, 188, 1, '', '2021-03-01 17:15:02', '', '2021-03-01 17:15:02', 0);
INSERT INTO `cart_item` VALUES (1741, 930, 188, 1, '18148789239', '2021-03-02 08:52:41', '', '2021-03-02 08:52:41', 0);
INSERT INTO `cart_item` VALUES (1761, 939, 188, 1, '18148789239', '2021-03-02 17:06:11', '', '2021-03-02 17:06:11', 0);
INSERT INTO `cart_item` VALUES (1776, 929, 188, 1, '18148789239', '2021-03-02 22:40:33', '', '2021-03-02 22:40:33', 0);
INSERT INTO `cart_item` VALUES (1777, 954, 188, 1, '18148789239', '2021-03-02 22:44:14', '', '2021-03-02 22:44:14', 0);
INSERT INTO `cart_item` VALUES (1778, 955, 188, 1, '18148789239', '2021-03-02 22:44:53', '', '2021-03-02 22:44:53', 0);
INSERT INTO `cart_item` VALUES (1782, 959, 188, 1, '18148789239', '2021-03-03 15:41:57', '', '2021-03-03 15:41:57', 0);
INSERT INTO `cart_item` VALUES (1783, 960, 188, 1, '18148789239', '2021-03-03 15:42:26', '', '2021-03-03 15:42:26', 0);
INSERT INTO `cart_item` VALUES (1785, 962, 188, 1, '18148789239', '2021-03-03 15:46:38', '', '2021-03-03 15:46:38', 0);

-- ----------------------------
-- Table structure for consultation
-- ----------------------------
DROP TABLE IF EXISTS `consultation`;
CREATE TABLE `consultation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `for_consultation` bigint(20) NULL DEFAULT NULL COMMENT '咨询',
  `product_id` bigint(20) NOT NULL COMMENT '商品',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `is_show` tinyint(1) NOT NULL COMMENT '是否显示',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK33228D687C62EDF8`(`member_id`) USING BTREE,
  INDEX `FK33228D68366B868C`(`for_consultation`) USING BTREE,
  INDEX `FK33228D6879F8D99A`(`product_id`) USING BTREE,
  CONSTRAINT `FK33228D6879F8D99A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '咨询' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of consultation
-- ----------------------------

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `condition` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '条件',
  `prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '前缀',
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '介绍',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '使用起始日期',
  `end_date` datetime NULL DEFAULT NULL COMMENT '使用结束日期',
  `is_enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `is_exchange` tinyint(1) NOT NULL COMMENT '是否允许积分兑换',
  `maximum_price` decimal(21, 6) NULL DEFAULT NULL COMMENT '最大商品价格',
  `maximum_quantity` int(11) NULL DEFAULT NULL COMMENT '最大商品数量',
  `minimum_price` decimal(21, 6) NULL DEFAULT NULL COMMENT '最小商品价格',
  `minimum_quantity` int(11) NULL DEFAULT NULL COMMENT '最小商品数量',
  `point` bigint(20) NULL DEFAULT NULL COMMENT '积分兑换数',
  `price_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '价格运算表达式',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of coupon
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_code
-- ----------------------------
DROP TABLE IF EXISTS `coupon_code`;
CREATE TABLE `coupon_code`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '号码',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券',
  `is_used` tinyint(1) NOT NULL COMMENT '是否已使用',
  `used_date` datetime NULL DEFAULT NULL COMMENT '使用日期',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE,
  INDEX `FKEF53A3A77C62EDF8`(`member_id`) USING BTREE,
  INDEX `FKEF53A3A75B638910`(`coupon_id`) USING BTREE,
  CONSTRAINT `FKEF53A3A75B638910` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠码' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of coupon_code
-- ----------------------------

-- ----------------------------
-- Table structure for delivery_center
-- ----------------------------
DROP TABLE IF EXISTS `delivery_center`;
CREATE TABLE `delivery_center`  (
  `id` bigint(20) NOT NULL COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `area_id` bigint(20) NULL DEFAULT NULL COMMENT '地区',
  `area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区名称',
  `zip_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK18EB77C139A0DADE`(`area_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发货点' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of delivery_center
-- ----------------------------

-- ----------------------------
-- Table structure for delivery_corp
-- ----------------------------
DROP TABLE IF EXISTS `delivery_corp`;
CREATE TABLE `delivery_corp`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代码',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物流公司' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of delivery_corp
-- ----------------------------
INSERT INTO `delivery_corp` VALUES (1, '北京发货中心', '', '', 0, '', NULL, '', '2020-09-24 11:32:10', 0);
INSERT INTO `delivery_corp` VALUES (2, '申通快递', 'http://www.sto.cn', 'shentong', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `delivery_corp` VALUES (3, '韵达快运', 'http://www.yundaex.com', 'yunda', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `delivery_corp` VALUES (4, '顺丰速递', 'http://www.sf-express.com', 'shunfeng', 4, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for delivery_template
-- ----------------------------
DROP TABLE IF EXISTS `delivery_template`;
CREATE TABLE `delivery_template`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `background` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '背景图',
  `height` int(11) NOT NULL COMMENT '高度',
  `width` int(11) NOT NULL COMMENT '宽度',
  `offsetx` int(11) NOT NULL COMMENT '偏移量X',
  `offsety` int(11) NOT NULL COMMENT '偏移量Y',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '快递单模板' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of delivery_template
-- ----------------------------

-- ----------------------------
-- Table structure for deposit_log
-- ----------------------------
DROP TABLE IF EXISTS `deposit_log`;
CREATE TABLE `deposit_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `type` int(11) NOT NULL COMMENT '类型',
  `member_id` bigint(20) NOT NULL COMMENT '会员',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员',
  `credit` decimal(21, 6) NOT NULL COMMENT '收入金额',
  `detinyint` decimal(21, 6) NOT NULL COMMENT '支出金额',
  `balance` decimal(21, 6) NOT NULL COMMENT '当前余额',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEBB7CC5F7C62EDF8`(`member_id`) USING BTREE,
  CONSTRAINT `deposit_log_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '预存款' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of deposit_log
-- ----------------------------

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NOT NULL COMMENT '会员ID',
  `creation_date` datetime NOT NULL COMMENT '反馈的时间',
  `suggestion` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '反馈内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------

-- ----------------------------
-- Table structure for friend_link
-- ----------------------------
DROP TABLE IF EXISTS `friend_link`;
CREATE TABLE `friend_link`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `type` int(11) NOT NULL COMMENT '类型',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'logo',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链接地址',
  `orders` int(11) NULL DEFAULT NULL COMMENT '订单',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '友情链接' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_link
-- ----------------------------

-- ----------------------------
-- Table structure for gift_item
-- ----------------------------
DROP TABLE IF EXISTS `gift_item`;
CREATE TABLE `gift_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `gift` bigint(20) NOT NULL COMMENT '赠品',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `promotion_id` bigint(20) NOT NULL COMMENT '促销',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `gift`(`gift`, `promotion_id`) USING BTREE,
  INDEX `FK2FB85243FD463A02`(`promotion_id`) USING BTREE,
  INDEX `FK2FB852438C9B75DB`(`gift`) USING BTREE,
  CONSTRAINT `FK2FB852438C9B75DB` FOREIGN KEY (`gift`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK2FB85243FD463A02` FOREIGN KEY (`promotion_id`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '赠品项' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gift_item
-- ----------------------------

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员',
  `parameter` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别,0未知,1男,2女性别',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `birth` datetime NULL DEFAULT NULL COMMENT '出生日期',
  `zip_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'openID',
  `area_id` bigint(20) NULL DEFAULT NULL COMMENT '地区',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'E-mail',
  `amount` decimal(27, 12) NOT NULL COMMENT '消费金额',
  `balance` decimal(27, 12) NOT NULL COMMENT '余额',
  `point` bigint(20) NOT NULL COMMENT '积分',
  `member_rank_id` bigint(20) NOT NULL COMMENT '会员等级',
  `register_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '注册IP',
  `attribute_value0` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值0',
  `attribute_value1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值1',
  `attribute_value2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值2',
  `attribute_value3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值3',
  `attribute_value4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值4',
  `attribute_value5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值5',
  `attribute_value6` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值6',
  `attribute_value7` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值7',
  `attribute_value8` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值8',
  `attribute_value9` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员注册项值9',
  `is_enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `is_locked` tinyint(1) NOT NULL COMMENT '是否锁定',
  `locked_date` datetime NULL DEFAULT NULL COMMENT '锁定日期',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录日期',
  `login_failure_count` int(11) NOT NULL COMMENT '连续登录失败次数',
  `login_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登录IP',
  `safe_key_expire` datetime NULL DEFAULT NULL COMMENT '安全密匙有效期',
  `safe_key_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全密匙值',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK92D398B939A0DADE`(`area_id`) USING BTREE,
  INDEX `FK92D398B937884F5B`(`member_rank_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 511 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (510, '18148789239', '', '聪明的竹子', '', 0, '18148789239', '', NULL, '', 'oMix35hVJKZIkOxXEliSONi6T-DU', 0, '', '', 0.000000000000, 0.000000000000, 0, 1, '', '', '', '', '', '', '', '', '', '', '', 0, 0, NULL, '2021-03-10 15:28:08', 0, '::1', NULL, '', '', '2021-01-25 16:12:21', '', '2021-03-10 15:28:08', 0);

-- ----------------------------
-- Table structure for member_attribute
-- ----------------------------
DROP TABLE IF EXISTS `member_attribute`;
CREATE TABLE `member_attribute`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `type` int(11) NOT NULL COMMENT '类型',
  `property_index` int(11) NULL DEFAULT NULL COMMENT '属性序号',
  `is_enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `is_required` tinyint(1) NOT NULL COMMENT '是否必填',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员注册项' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for member_attribute_option
-- ----------------------------
DROP TABLE IF EXISTS `member_attribute_option`;
CREATE TABLE `member_attribute_option`  (
  `member_attribute` bigint(20) NOT NULL,
  `options` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  INDEX `FKC3DC263E8A8815`(`member_attribute`) USING BTREE,
  CONSTRAINT `FKC3DC263E8A8815` FOREIGN KEY (`member_attribute`) REFERENCES `member_attribute` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member_attribute_option
-- ----------------------------

-- ----------------------------
-- Table structure for member_favorite_product
-- ----------------------------
DROP TABLE IF EXISTS `member_favorite_product`;
CREATE TABLE `member_favorite_product`  (
  `favorite_members` bigint(20) NOT NULL,
  `favorite_products` bigint(20) NOT NULL,
  PRIMARY KEY (`favorite_members`, `favorite_products`) USING BTREE,
  INDEX `FK44DF1412A43B40D4`(`favorite_members`) USING BTREE,
  INDEX `FK44DF1412830D5552`(`favorite_products`) USING BTREE,
  CONSTRAINT `FK44DF1412830D5552` FOREIGN KEY (`favorite_products`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK44DF1412A43B40D4` FOREIGN KEY (`favorite_members`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member_favorite_product
-- ----------------------------

-- ----------------------------
-- Table structure for member_rank
-- ----------------------------
DROP TABLE IF EXISTS `member_rank`;
CREATE TABLE `member_rank`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `amount` decimal(21, 6) NULL DEFAULT NULL COMMENT '消费金额',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认',
  `is_special` tinyint(1) NOT NULL COMMENT '是否特殊',
  `scale` double NOT NULL COMMENT '优惠比例',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `amount`(`amount`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员等级' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member_rank
-- ----------------------------
INSERT INTO `member_rank` VALUES (1, '普通会员', 0.000000, 1, 0, 1, NULL, NULL, '管理员', '2016-08-10 15:16:26', 0);
INSERT INTO `member_rank` VALUES (2, '银牌会员', 1000.000000, 0, 0, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `member_rank` VALUES (3, '金牌会员', 10000.000000, 0, 0, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `member_rank` VALUES (4, '白金会员', 100000.000000, 0, 0, 0.99, NULL, NULL, NULL, NULL, 0);
INSERT INTO `member_rank` VALUES (5, '贵宾会员', NULL, 0, 1, 0.95, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `sender_id` bigint(20) NULL DEFAULT NULL COMMENT '发件人',
  `receiver_id` bigint(20) NULL DEFAULT NULL COMMENT '收件人',
  `for_message` bigint(20) NULL DEFAULT NULL COMMENT '原消息',
  `receiver_read` tinyint(1) NOT NULL COMMENT '收件人已读',
  `receiver_delete` tinyint(1) NOT NULL COMMENT '收件人删除',
  `sender_read` tinyint(1) NOT NULL COMMENT '发件人已读',
  `sender_delete` tinyint(1) NOT NULL COMMENT '发件人删除',
  `is_draft` tinyint(1) NOT NULL COMMENT '是否为草稿',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKC7FBB5C886A07D93`(`sender_id`) USING BTREE,
  INDEX `FKC7FBB5C8E2B39A54`(`for_message`) USING BTREE,
  INDEX `FKC7FBB5C88C6C4D4D`(`receiver_id`) USING BTREE,
  CONSTRAINT `FKC7FBB5C886A07D93` FOREIGN KEY (`sender_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKC7FBB5C88C6C4D4D` FOREIGN KEY (`receiver_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKC7FBB5C8E2B39A54` FOREIGN KEY (`for_message`) REFERENCES `message` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for message_config
-- ----------------------------
DROP TABLE IF EXISTS `message_config`;
CREATE TABLE `message_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_ID',
  `is_mail_enabled` tinyint(1) NOT NULL COMMENT '是否启用邮件',
  `is_sms_enabled` tinyint(1) NOT NULL COMMENT '是否启用短信',
  `type` int(11) NOT NULL COMMENT '类型',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_config
-- ----------------------------

-- ----------------------------
-- Table structure for navigation
-- ----------------------------
DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链接地址',
  `is_blank_target` tinyint(1) NOT NULL COMMENT '是否新窗口打开',
  `position` int(11) NOT NULL COMMENT '位置',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of navigation
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `status` int(11) NOT NULL COMMENT '订单状态',
  `amount` decimal(21, 6) NOT NULL COMMENT '订单金额',
  `amount_paid` decimal(21, 6) NOT NULL COMMENT '已付金额',
  `coupon_discount` decimal(21, 6) NOT NULL COMMENT '优惠券折扣',
  `offset_amount` decimal(21, 6) NOT NULL COMMENT '调整金额',
  `price` decimal(21, 6) NOT NULL COMMENT '商品价格',
  `fee` decimal(21, 6) NOT NULL COMMENT '支付手续费',
  `freight` decimal(21, 6) NOT NULL COMMENT '运费',
  `reward_point` bigint(20) NOT NULL COMMENT '赠送积分',
  `consignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人',
  `area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区名称',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `zip_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `exchange_point` bigint(20) NOT NULL COMMENT '兑换积分',
  `is_allocated_stock` tinyint(1) NOT NULL COMMENT '是否已分配库存',
  `is_exchange_point` tinyint(1) NOT NULL COMMENT '是否已兑换积分',
  `is_use_coupon_code` tinyint(1) NOT NULL COMMENT '是否已使用优惠码',
  `is_notify` tinyint(1) NOT NULL COMMENT '是否通知',
  `invoice_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发票内容',
  `invoice_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发票标题',
  `tax` decimal(21, 6) NOT NULL COMMENT '税金',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附言',
  `payment_method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付方式名称',
  `payment_method_type` int(11) NULL DEFAULT NULL COMMENT '支付方式类型',
  `promotion_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '促销名称',
  `promotion_discount` decimal(21, 6) NOT NULL COMMENT '促销折扣',
  `expire` datetime NULL DEFAULT NULL COMMENT '到期时间',
  `lock_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '锁定KEY',
  `lock_expire` datetime NULL DEFAULT NULL COMMENT '锁定到期时间',
  `weight` int(11) NOT NULL COMMENT '重量',
  `source` int(11) NULL DEFAULT NULL COMMENT '订单来源',
  `type` int(11) NOT NULL COMMENT '类型',
  `quantity` int(11) NOT NULL COMMENT '商品数量',
  `refund_amount` decimal(21, 9) NOT NULL COMMENT '退款金额',
  `returned_quantity` int(11) NOT NULL COMMENT '退款商品数量',
  `shipped_quantity` int(11) NOT NULL COMMENT '已发货数量',
  `shipping_method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配送方式名称',
  `shipping_date` datetime NULL DEFAULT NULL COMMENT '配送时间',
  `payment_method_id` bigint(20) NULL DEFAULT NULL COMMENT '支付方式',
  `shipping_method_id` bigint(20) NULL DEFAULT NULL COMMENT '配送方式',
  `delivery_corp_id` bigint(20) NULL DEFAULT NULL COMMENT '物流公司',
  `delivery_corp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `operator_id` bigint(20) NULL DEFAULT NULL COMMENT '操作员',
  `area_id` bigint(20) NULL DEFAULT NULL COMMENT '地区',
  `member_id` bigint(20) NOT NULL COMMENT '会员',
  `coupon_code_id` bigint(20) NULL DEFAULT NULL COMMENT '优惠码',
  `complete_date` datetime NULL DEFAULT NULL COMMENT '完成日期',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `FK25E6B94F67F7C585`(`shipping_method_id`) USING BTREE,
  INDEX `FK25E6B94F39A0DADE`(`area_id`) USING BTREE,
  INDEX `FK25E6B94F7C62EDF8`(`member_id`) USING BTREE,
  INDEX `FK25E6B94FC050045D`(`coupon_code_id`) USING BTREE,
  INDEX `FK25E6B94FD7122AAF`(`operator_id`) USING BTREE,
  INDEX `FK25E6B94FD3A8BE7D`(`payment_method_id`) USING BTREE,
  INDEX `delivery_corp_id`(`delivery_corp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `order_coupon`;
CREATE TABLE `order_coupon`  (
  `orders` bigint(20) NOT NULL COMMENT '订单',
  `coupons` bigint(20) NOT NULL COMMENT '优惠券',
  INDEX `FKA3F6D516E538DDF7`(`coupons`) USING BTREE,
  INDEX `FKA3F6D516B992E8EF`(`orders`) USING BTREE,
  CONSTRAINT `FKA3F6D516B992E8EF` FOREIGN KEY (`orders`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKA3F6D516E538DDF7` FOREIGN KEY (`coupons`) REFERENCES `coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `price` decimal(21, 6) NOT NULL COMMENT '商品价格',
  `weight` int(11) NULL DEFAULT NULL COMMENT '商品重量',
  `thumbnail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品缩略图',
  `specifications` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规格',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `shipped_quantity` int(11) NOT NULL COMMENT '已发货数量',
  `return_quantity` int(11) NOT NULL COMMENT '已退货数量',
  `is_gift` tinyint(1) NOT NULL COMMENT '是否为赠品',
  `is_delivery` tinyint(1) NOT NULL COMMENT '是否需要物流',
  `order_id` bigint(20) NOT NULL COMMENT '订单',
  `sku_id` bigint(20) NULL DEFAULT NULL COMMENT 'SKU',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKD69FF403B992E8EF`(`order_id`) USING BTREE,
  INDEX `sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `FKD69FF403B992E8EF` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单项' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------

-- ----------------------------
-- Table structure for order_log
-- ----------------------------
DROP TABLE IF EXISTS `order_log`;
CREATE TABLE `order_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `type` int(11) NOT NULL COMMENT '类型',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员',
  `order_id` bigint(20) NOT NULL COMMENT '订单',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKF6684C54B992E8EF`(`order_id`) USING BTREE,
  CONSTRAINT `FKF6684C54B992E8EF` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_log
-- ----------------------------

-- ----------------------------
-- Table structure for parameter
-- ----------------------------
DROP TABLE IF EXISTS `parameter`;
CREATE TABLE `parameter`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `parameter_group_id` bigint(20) NOT NULL COMMENT '参数组',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK8238FD2A818BF383`(`parameter_group_id`) USING BTREE,
  CONSTRAINT `FK8238FD2A818BF383` FOREIGN KEY (`parameter_group_id`) REFERENCES `parameter_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of parameter
-- ----------------------------

-- ----------------------------
-- Table structure for parameter_group
-- ----------------------------
DROP TABLE IF EXISTS `parameter_group`;
CREATE TABLE `parameter_group`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `product_category_id` bigint(20) NOT NULL COMMENT '绑定分类',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKD68A4F2AD7629117`(`product_category_id`) USING BTREE,
  CONSTRAINT `FKD68A4F2AD7629117` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of parameter_group
-- ----------------------------
INSERT INTO `parameter_group` VALUES (66, '', 241, 0, '', '2021-01-22 14:25:39', '管理员', '2021-02-20 10:33:05', 1);
INSERT INTO `parameter_group` VALUES (67, '', 242, 0, '', '2021-01-26 10:12:47', '管理员', '2021-02-20 10:33:05', 1);

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `method` int(11) NOT NULL COMMENT '方式',
  `payment_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `bank` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收款银行',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收款账号',
  `fee` decimal(21, 6) NOT NULL COMMENT '支付手续费',
  `amount` decimal(21, 6) NOT NULL COMMENT '付款金额',
  `payer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '付款人',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员',
  `payment_date` datetime NULL DEFAULT NULL COMMENT '付款日期',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `payment_plugin_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付插件ID',
  `expire` datetime NULL DEFAULT NULL COMMENT '到期时间',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `FK602CE7C77C62EDF8`(`member_id`) USING BTREE,
  INDEX `FK602CE7C7B992E8EF`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收款单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for payment_log
-- ----------------------------
DROP TABLE IF EXISTS `payment_log`;
CREATE TABLE `payment_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `amount` decimal(20, 6) NOT NULL COMMENT '支付金额',
  `fee` decimal(20, 6) NOT NULL COMMENT '支付手续费',
  `payment_plugin_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付插件ID',
  `payment_plugin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付插件名称',
  `sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '编号',
  `status` int(11) NOT NULL COMMENT '状态',
  `type` int(11) NOT NULL COMMENT '类型',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` datetime NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `member_id`(`member_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `payment_log_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `payment_log_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment_log
-- ----------------------------

-- ----------------------------
-- Table structure for payment_method
-- ----------------------------
DROP TABLE IF EXISTS `payment_method`;
CREATE TABLE `payment_method`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `method` int(11) NOT NULL COMMENT '方式',
  `timeout` int(11) NULL DEFAULT NULL COMMENT '超时时间',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '介绍',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支付方式' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment_method
-- ----------------------------
INSERT INTO `payment_method` VALUES (1, '网上支付', 0, 1440, 'http://localhost:8080/upload/image/online.gif', '支持支付宝、财付通、以及大多数网上银行支付', NULL, 1, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `payment_method` VALUES (2, '银行汇款', 0, 1, '/static/upload/image/202009/98a7d3cf-6077-4d38-8e8d-9ba07ccc5cff-source.png', '支持工行、建行、农行汇款支付，收款时间一般为汇款后的1-2个工作日', '<p>啊啊啊</p>', 2, 0, '', NULL, 'yangcheng', '2020-09-11 17:02:46', 0);
INSERT INTO `payment_method` VALUES (3, '货到付款', 1, 0, 'http://localhost:8080/upload/image/cash_on_delivery.gif', '由快递公司送货上门，您签收后直接将货款交付给快递员', '', 3, 1, '', NULL, 'yangcheng', '2020-09-11 16:52:23', 0);

-- ----------------------------
-- Table structure for payment_shipping_method
-- ----------------------------
DROP TABLE IF EXISTS `payment_shipping_method`;
CREATE TABLE `payment_shipping_method`  (
  `payment_methods` bigint(20) NOT NULL,
  `shipping_methods` bigint(20) NOT NULL,
  PRIMARY KEY (`payment_methods`, `shipping_methods`) USING BTREE,
  INDEX `FKC230A01A85883714`(`shipping_methods`) USING BTREE,
  INDEX `FKC230A01AA2ED13BC`(`payment_methods`) USING BTREE,
  CONSTRAINT `FKC230A01A85883714` FOREIGN KEY (`shipping_methods`) REFERENCES `shipping_method` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKC230A01AA2ED13BC` FOREIGN KEY (`payment_methods`) REFERENCES `payment_method` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment_shipping_method
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '值',
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属模块',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `value`(`value`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '商品管理 ', 'adminProduct', 'productGroup', NULL, '管理员', '2016-10-09 11:04:33', NULL, NULL, 0);
INSERT INTO `permission` VALUES (2, '商品分类管理', 'adminProductCategory', 'productGroup', NULL, '管理员', '2016-10-09 11:05:34', '管理员', '2016-10-09 11:05:51', 0);
INSERT INTO `permission` VALUES (3, '商品参数管理', 'adminParameterGroup', 'productGroup', NULL, '管理员', '2016-10-09 11:06:42', NULL, NULL, 0);
INSERT INTO `permission` VALUES (4, '商品属性管理', 'adminAttribute', 'productGroup', NULL, '管理员', '2016-10-09 11:10:25', NULL, NULL, 0);
INSERT INTO `permission` VALUES (5, '规格管理', 'adminSpecification', 'productGroup', NULL, '管理员', '2016-10-09 11:11:00', NULL, NULL, 0);
INSERT INTO `permission` VALUES (6, '品牌管理', 'adminBrand', 'productGroup', NULL, '管理员', '2016-10-09 11:11:34', NULL, NULL, 0);
INSERT INTO `permission` VALUES (7, '到货通知管理', 'adminProductNotify', 'productGroup', NULL, '管理员', '2016-10-09 11:12:23', NULL, NULL, 0);
INSERT INTO `permission` VALUES (8, '订单管理', 'adminOrder', 'orderGroup', NULL, '管理员', '2016-10-09 13:53:29', NULL, NULL, 0);
INSERT INTO `permission` VALUES (9, '打印管理', 'adminPrint', 'orderGroup', NULL, '管理员', '2016-10-09 13:54:06', NULL, NULL, 0);
INSERT INTO `permission` VALUES (10, '收款管理', 'adminPayment', 'orderGroup', NULL, '管理员', '2016-10-09 13:54:50', NULL, NULL, 0);
INSERT INTO `permission` VALUES (11, '退款管理', 'adminRefunds', 'orderGroup', NULL, '管理员', '2016-10-09 13:55:27', NULL, NULL, 0);
INSERT INTO `permission` VALUES (12, '发货管理', 'adminShipping', 'orderGroup', NULL, '管理员', '2016-10-09 13:56:02', NULL, NULL, 0);
INSERT INTO `permission` VALUES (13, '退货管理', 'adminReturns', 'orderGroup', NULL, '管理员', '2016-10-09 13:56:32', NULL, NULL, 0);
INSERT INTO `permission` VALUES (14, '发货点管理', 'adminDeliveryCenter', 'orderGroup', NULL, '管理员', '2016-10-09 13:57:12', NULL, NULL, 0);
INSERT INTO `permission` VALUES (15, '快递单模板管理', 'adminDeliveryTemplate', 'orderGroup', NULL, '管理员', '2016-10-09 13:57:50', NULL, NULL, 0);
INSERT INTO `permission` VALUES (16, '会员管理', 'adminMember', 'memberGroup', NULL, '管理员', '2016-10-09 13:58:21', NULL, NULL, 0);
INSERT INTO `permission` VALUES (17, '会员等级管理', 'adminMemberRank', 'memberGroup', NULL, '管理员', '2016-10-09 13:58:56', NULL, NULL, 0);
INSERT INTO `permission` VALUES (18, '会员注册项管理', 'adminMemberAttribute', 'memberGroup', NULL, '管理员', '2016-10-09 13:59:28', NULL, NULL, 0);
INSERT INTO `permission` VALUES (19, '评论管理', 'adminReview', 'memberGroup', NULL, '管理员', '2016-10-09 14:00:01', NULL, NULL, 0);
INSERT INTO `permission` VALUES (20, '咨询管理', 'adminConsultation', 'memberGroup', NULL, '管理员', '2016-10-09 14:00:37', NULL, NULL, 0);
INSERT INTO `permission` VALUES (21, '导航管理', 'adminNavigation', 'contentGroup', NULL, '管理员', '2016-10-09 14:01:11', NULL, NULL, 0);
INSERT INTO `permission` VALUES (22, '文章管理', 'adminArticle', 'contentGroup', NULL, '管理员', '2016-10-09 14:01:47', NULL, NULL, 0);
INSERT INTO `permission` VALUES (23, '文章分类管理', 'adminArticleCategory', 'contentGroup', NULL, '管理员', '2016-10-09 14:02:22', NULL, NULL, 0);
INSERT INTO `permission` VALUES (24, '标签管理', 'adminTag', 'contentGroup', NULL, '管理员', '2016-10-09 14:02:55', NULL, NULL, 0);
INSERT INTO `permission` VALUES (25, '友情链接管理', 'adminFriendLink', 'contentGroup', NULL, '管理员', '2016-10-09 14:03:43', NULL, NULL, 0);
INSERT INTO `permission` VALUES (26, '广告位管理', 'adminAdPosition', 'contentGroup', NULL, '管理员', '2016-10-09 14:04:17', NULL, NULL, 0);
INSERT INTO `permission` VALUES (27, '广告管理', 'adminAd', 'contentGroup', NULL, '管理员', '2016-10-09 14:04:49', NULL, NULL, 0);
INSERT INTO `permission` VALUES (28, '模板管理', 'adminTemplate', 'contentGroup', NULL, '管理员', '2016-10-09 14:05:18', NULL, NULL, 0);
INSERT INTO `permission` VALUES (29, '缓存管理', 'adminCache', 'contentGroup', NULL, '管理员', '2016-10-09 14:05:52', NULL, NULL, 0);
INSERT INTO `permission` VALUES (30, '静态化管理', 'adminStatic', 'contentGroup', NULL, '管理员', '2016-10-09 14:06:22', NULL, NULL, 0);
INSERT INTO `permission` VALUES (31, '索引管理', 'adminIndex', 'contentGroup', NULL, '管理员', '2016-10-09 14:07:01', NULL, NULL, 0);
INSERT INTO `permission` VALUES (32, '促销管理', 'adminPromotion', 'marketingGroup', NULL, '管理员', '2016-10-09 14:07:37', NULL, NULL, 0);
INSERT INTO `permission` VALUES (33, '优惠券管理', 'adminCoupon', 'marketingGroup', NULL, '管理员', '2016-10-09 14:08:09', NULL, NULL, 0);
INSERT INTO `permission` VALUES (34, 'SEO设置', 'adminSeo', 'marketingGroup', NULL, '管理员', '2016-10-09 14:08:43', NULL, NULL, 0);
INSERT INTO `permission` VALUES (35, 'Sitemap管理', 'adminSitemap', 'marketingGroup', NULL, '管理员', '2016-10-09 14:09:14', NULL, NULL, 0);
INSERT INTO `permission` VALUES (36, '访问统计管理', 'adminStatistics', 'statisticsGroup', NULL, '管理员', '2016-10-09 14:11:12', NULL, NULL, 0);
INSERT INTO `permission` VALUES (37, '销售统计', 'adminSales', 'statisticsGroup', NULL, '管理员', '2016-10-09 14:11:47', NULL, NULL, 0);
INSERT INTO `permission` VALUES (38, '销售排行', 'adminSalesRanking', 'statisticsGroup', NULL, '管理员', '2016-10-09 14:12:20', NULL, NULL, 0);
INSERT INTO `permission` VALUES (39, '消费排行', 'adminPurchaseRanking', 'statisticsGroup', NULL, '管理员', '2016-10-09 14:12:55', NULL, NULL, 0);
INSERT INTO `permission` VALUES (40, '预存款', 'adminDeposit', 'memberGroup', NULL, '管理员', '2016-10-09 14:13:25', NULL, NULL, 0);
INSERT INTO `permission` VALUES (41, '系统设置', 'adminSetting', 'systemGroup', NULL, '管理员', '2016-10-09 14:14:08', NULL, NULL, 0);
INSERT INTO `permission` VALUES (42, '地区管理', 'adminArea', 'systemGroup', NULL, '管理员', '2016-10-09 14:14:39', NULL, NULL, 0);
INSERT INTO `permission` VALUES (43, '支付方式管理', 'adminPaymentMethod', 'systemGroup', NULL, '管理员', '2016-10-09 14:15:14', NULL, NULL, 0);
INSERT INTO `permission` VALUES (44, '配送方式管理', 'adminShippingMethod', 'systemGroup', NULL, '管理员', '2016-10-09 14:15:47', NULL, NULL, 0);
INSERT INTO `permission` VALUES (45, '物流公司管理', 'adminDeliveryCorp', 'systemGroup', NULL, '管理员', '2016-10-09 14:16:19', NULL, NULL, 0);
INSERT INTO `permission` VALUES (46, '支付插件', 'adminPaymentPlugin', 'systemGroup', NULL, '管理员', '2016-10-09 14:16:50', NULL, NULL, 0);
INSERT INTO `permission` VALUES (47, '存储插件', 'adminStoragePlugin', 'systemGroup', NULL, '管理员', '2016-10-09 14:17:27', NULL, NULL, 0);
INSERT INTO `permission` VALUES (48, '管理员管理', 'adminAdmin', 'systemGroup', NULL, '管理员', '2016-10-09 14:18:21', '管理员', '2016-10-10 10:50:25', 0);
INSERT INTO `permission` VALUES (49, '角色管理', 'adminRole', 'systemGroup', NULL, '管理员', '2016-10-09 14:19:40', NULL, NULL, 0);
INSERT INTO `permission` VALUES (50, '消息管理', 'adminMessage', 'systemGroup', NULL, '管理员', '2016-10-09 14:20:12', NULL, NULL, 0);
INSERT INTO `permission` VALUES (51, '日志管理', 'adminLog', 'systemGroup', NULL, '管理员', '2016-10-09 14:20:39', NULL, NULL, 0);
INSERT INTO `permission` VALUES (52, '库存管理', 'adminStock', 'productGroup', NULL, NULL, '2020-10-14 09:34:45', NULL, NULL, 0);
INSERT INTO `permission` VALUES (53, '登录插件管理', 'adminLoginPlugin', 'systemGroup', NULL, NULL, '2020-10-14 15:55:51', NULL, NULL, 0);
INSERT INTO `permission` VALUES (55, '商品标签管理', 'adminProductTag', 'productGroup', NULL, NULL, '2020-10-14 15:55:48', NULL, NULL, 0);
INSERT INTO `permission` VALUES (56, '积分管理', 'adminPoint', 'memberGroup', NULL, NULL, '2020-10-14 15:55:46', NULL, NULL, 0);
INSERT INTO `permission` VALUES (57, '消息配置管理', 'adminMessageConfig', 'memberGroup', NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for permission_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role`  (
  `permissions` bigint(20) NOT NULL,
  `roles` bigint(20) NOT NULL COMMENT '角色',
  PRIMARY KEY (`permissions`, `roles`) USING BTREE,
  INDEX `FK_permission_role_role`(`roles`) USING BTREE,
  INDEX `permissions`(`permissions`) USING BTREE,
  CONSTRAINT `FK_permission_role_permission` FOREIGN KEY (`permissions`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_permission_role_role` FOREIGN KEY (`roles`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission_role
-- ----------------------------

-- ----------------------------
-- Table structure for plugin_config
-- ----------------------------
DROP TABLE IF EXISTS `plugin_config`;
CREATE TABLE `plugin_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `plugin_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件ID',
  `attributes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '属性',
  `is_enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `type` int(11) NOT NULL COMMENT '类型',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plugin_id`(`plugin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '插件配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of plugin_config
-- ----------------------------
INSERT INTO `plugin_config` VALUES (8, 'weixinPaymentPlugin', '{\"appId\":\"wx7838f486e14b1a24\",\"fee\":\"0\",\"logo\":\"/upload/image/icon_wx_pay.png\",\"description\":\"\",\"appSecret\":\"d1b5008dcb3eeb4cf3e6e69aabe38584\",\"mch_id\":\"1302827801\",\"feeType\":\"scale\",\"paymentName\":\"微信支付\",\"paternerKey\":\"zaqwsxcdeijnmkopl0192837465rtyui\"}', 1, 7, 2, 'BeeShop', NULL, '', '2021-03-03 15:54:47', 0);
INSERT INTO `plugin_config` VALUES (9, 'weixinLoginPlugin', '{\"appSecret\":\"13f2df83834670bbf5dd87f7ae4813c5\",\"appId\":\"wx6e5a217a5b46dd16\",\"description\":\"1\",\"logo\":\"/b2b2c/5.0/201601/57aa3e84-3c29-4e44-b5f5-327c17501c5c.png\",\"loginMethodName\":\"微信登录\"}', 1, 0, 1, 'BeeShop', NULL, '', '2020-09-15 10:45:36', 0);
INSERT INTO `plugin_config` VALUES (10, 'localStoragePlugin', '{\"name\":\"本地存储文件\"}', 1, 1, 0, 'BeeShop', NULL, '', '2020-09-15 11:13:06', 0);

-- ----------------------------
-- Table structure for point_log
-- ----------------------------
DROP TABLE IF EXISTS `point_log`;
CREATE TABLE `point_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `balance` bigint(20) NOT NULL COMMENT '当前积分',
  `credit` bigint(20) NOT NULL COMMENT '获取积分',
  `debit` bigint(20) NOT NULL COMMENT '扣除积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `type` int(11) NOT NULL COMMENT '类型',
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作员',
  `member_id` bigint(20) NOT NULL COMMENT '会员',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `member_id`(`member_id`) USING BTREE,
  CONSTRAINT `point_log_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of point_log
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `caption` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展示图片',
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `weight` int(11) NULL DEFAULT NULL COMMENT '重量',
  `type` int(11) NOT NULL COMMENT '类型',
  `is_marketable` tinyint(1) NOT NULL COMMENT '是否上架',
  `is_list` tinyint(1) NOT NULL COMMENT '是否列出',
  `is_top` tinyint(1) NOT NULL COMMENT '是否置顶',
  `is_delivery` tinyint(1) NOT NULL COMMENT '是否需要物流',
  `is_gift` tinyint(1) NOT NULL COMMENT '是否为赠品',
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '介绍',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '搜索关键词',
  `seo_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面标题',
  `seo_keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面关键词',
  `seo_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面描述',
  `score` float NOT NULL COMMENT '评分',
  `total_score` bigint(20) NOT NULL COMMENT '总评分',
  `score_count` bigint(20) NOT NULL COMMENT '评分数',
  `hits` bigint(20) NOT NULL COMMENT '点击数',
  `week_hits` bigint(20) NOT NULL COMMENT '周点击数',
  `month_hits` bigint(20) NOT NULL COMMENT '月点击数',
  `sales` bigint(20) NOT NULL COMMENT '销量',
  `week_sales` bigint(20) NOT NULL COMMENT '周销量',
  `month_sales` bigint(20) NOT NULL COMMENT '月销量',
  `week_hits_date` datetime NOT NULL COMMENT '周点击数更新日期',
  `month_hits_date` datetime NOT NULL COMMENT '月点击数更新日期',
  `week_sales_date` datetime NOT NULL COMMENT '周销量更新日期',
  `month_sales_date` datetime NOT NULL COMMENT '月销量更新日期',
  `attribute_value0` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值0',
  `attribute_value1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值1',
  `attribute_value2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值2',
  `attribute_value3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值3',
  `attribute_value4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值4',
  `attribute_value5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值5',
  `attribute_value6` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值6',
  `attribute_value7` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值7',
  `attribute_value8` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值8',
  `attribute_value9` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值9',
  `attribute_value10` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值10',
  `attribute_value11` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值11',
  `attribute_value12` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值12',
  `attribute_value13` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值13',
  `attribute_value14` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值14',
  `attribute_value15` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值15',
  `attribute_value16` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值16',
  `attribute_value17` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值17',
  `attribute_value18` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性值18',
  `attribute_value19` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品属性19',
  `brand_id` bigint(20) NULL DEFAULT NULL COMMENT '品牌',
  `product_category_id` bigint(20) NOT NULL COMMENT '商品分类',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `FK7C9E82B0D7629117`(`product_category_id`) USING BTREE,
  INDEX `FK7C9E82B0FA9695CA`(`brand_id`) USING BTREE,
  CONSTRAINT `FK7C9E82B0D7629117` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK7C9E82B0FA9695CA` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 433 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (432, '358957542644121600', '2016年红葡萄酒 ', '作为波尔多1855二级庄，因品质出众被公认为“超二级庄”。爱士图尔还是名人雅士的宠儿，维多利亚女王、沙皇尼古拉斯、拿破仑三世等重量级人物都对其钟爱有加。传闻伟大哲学家马克思结婚时，恩格斯就以一箱爱士图尔作为贺礼赠予好友。2016年份是继2015之后波尔多又一十分优秀的年份。2016爱士图尔获帕克团队和詹姆斯·萨克林的双百分评价。', '/static/upload/image/202102/dfd83649-4af3-4d3f-b0c8-8ba492a6fc40-medium.png', '', 0, 0, 1, 1, 1, 0, 0, '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-01-22 11:54:40', '2021-01-22 11:54:40', '2021-01-22 11:54:40', '2021-01-22 11:54:40', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 25, 242, '管理员', '2021-01-22 11:54:40', '管理员', '2021-02-19 18:05:55', 0);

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `seo_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面标题',
  `seo_keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面关键词',
  `seo_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面描述',
  `tree_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '树路径',
  `grade` int(11) NOT NULL COMMENT '层级',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级分类',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `is_marketable` tinyint(1) NULL DEFAULT NULL COMMENT '是否上架',
  `is_top` tinyint(1) NULL DEFAULT NULL COMMENT '是否置顶',
  `is_show` tinyint(1) NULL DEFAULT NULL COMMENT '是否显示',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK1B7971ADFBDD5B73`(`parent_id`) USING BTREE,
  CONSTRAINT `FK1B7971ADFBDD5B73` FOREIGN KEY (`parent_id`) REFERENCES `product_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 243 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES (241, '全部分类', '', '', '', ',', 0, '', NULL, 0, 1, 1, 1, '', '2021-01-22 11:44:29', '', '2021-02-19 18:07:02', 0);
INSERT INTO `product_category` VALUES (242, '红酒', '', '', '', ',241,', 1, '', 241, 0, 1, 1, 1, '', '2021-01-22 11:45:48', '', '2021-01-26 09:53:06', 0);

-- ----------------------------
-- Table structure for product_category_brand
-- ----------------------------
DROP TABLE IF EXISTS `product_category_brand`;
CREATE TABLE `product_category_brand`  (
  `product_categories` bigint(20) NOT NULL,
  `brands` bigint(20) NOT NULL,
  PRIMARY KEY (`product_categories`, `brands`) USING BTREE,
  INDEX `FKE42D6A75A2AB700F`(`brands`) USING BTREE,
  INDEX `FKE42D6A758C4C0635`(`product_categories`) USING BTREE,
  CONSTRAINT `FKE42D6A758C4C0635` FOREIGN KEY (`product_categories`) REFERENCES `product_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKE42D6A75A2AB700F` FOREIGN KEY (`brands`) REFERENCES `brand` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_category_brand
-- ----------------------------

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `product_id` bigint(20) NOT NULL COMMENT '商品',
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原图片',
  `large` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大图片',
  `medium` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '中图片',
  `thumbnail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK66470ABC79F8D99A`(`product_id`) USING BTREE,
  CONSTRAINT `FK66470ABC79F8D99A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 287 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES (285, '', 432, '/static/upload/image/202101/d4556ef8-9306-4cd4-9463-bc482601dcb3-source.png', '/static/upload/image/202101/d4556ef8-9306-4cd4-9463-bc482601dcb3-large.png', '/static/upload/image/202101/d4556ef8-9306-4cd4-9463-bc482601dcb3-medium.png', '/static/upload/image/202101/d4556ef8-9306-4cd4-9463-bc482601dcb3-thumbnail.png', 0, '', '2021-01-25 17:35:29', '', '2021-02-19 18:05:55', 1);
INSERT INTO `product_image` VALUES (286, '', 432, '/static/upload/image/202102/40b47bbf-f860-4461-84e7-8fbbc3cc4f71-source.png', '/static/upload/image/202102/40b47bbf-f860-4461-84e7-8fbbc3cc4f71-large.png', '/static/upload/image/202102/40b47bbf-f860-4461-84e7-8fbbc3cc4f71-medium.png', '/static/upload/image/202102/40b47bbf-f860-4461-84e7-8fbbc3cc4f71-thumbnail.png', 0, '', '2021-02-19 18:05:55', '', '2021-02-19 18:05:55', 0);

-- ----------------------------
-- Table structure for product_member_price
-- ----------------------------
DROP TABLE IF EXISTS `product_member_price`;
CREATE TABLE `product_member_price`  (
  `product` bigint(20) NOT NULL,
  `member_price` decimal(19, 2) NULL DEFAULT NULL,
  `member_price_key` bigint(20) NOT NULL,
  PRIMARY KEY (`product`, `member_price_key`) USING BTREE,
  INDEX `FKDCCD88935CCD83AE`(`member_price_key`) USING BTREE,
  INDEX `FKDCCD889379F8D99A`(`product`) USING BTREE,
  CONSTRAINT `FKDCCD88935CCD83AE` FOREIGN KEY (`member_price_key`) REFERENCES `member_rank` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKDCCD889379F8D99A` FOREIGN KEY (`product`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_member_price
-- ----------------------------

-- ----------------------------
-- Table structure for product_notify
-- ----------------------------
DROP TABLE IF EXISTS `product_notify`;
CREATE TABLE `product_notify`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'E-mail',
  `has_sent` tinyint(1) NOT NULL COMMENT '是否已发送',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `product_id` bigint(20) NOT NULL COMMENT '商品',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKDCB1ABB87C62EDF8`(`member_id`) USING BTREE,
  INDEX `FKDCB1ABB879F8D99A`(`product_id`) USING BTREE,
  CONSTRAINT `FKDCB1ABB879F8D99A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKDCB1ABB87C62EDF8` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '到货通知' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_notify
-- ----------------------------

-- ----------------------------
-- Table structure for product_parameter_value
-- ----------------------------
DROP TABLE IF EXISTS `product_parameter_value`;
CREATE TABLE `product_parameter_value`  (
  `product` bigint(20) NOT NULL,
  `parameter_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parameter_value_key` bigint(20) NOT NULL,
  PRIMARY KEY (`product`, `parameter_value_key`) USING BTREE,
  INDEX `FK1B76FDCCEDA221E0`(`parameter_value_key`) USING BTREE,
  INDEX `FK1B76FDCC79F8D99A`(`product`) USING BTREE,
  CONSTRAINT `FK1B76FDCC79F8D99A` FOREIGN KEY (`product`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK1B76FDCCEDA221E0` FOREIGN KEY (`parameter_value_key`) REFERENCES `parameter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_parameter_value
-- ----------------------------

-- ----------------------------
-- Table structure for product_specification
-- ----------------------------
DROP TABLE IF EXISTS `product_specification`;
CREATE TABLE `product_specification`  (
  `products` bigint(20) NOT NULL,
  `specifications` bigint(20) NOT NULL,
  PRIMARY KEY (`products`, `specifications`) USING BTREE,
  INDEX `FK622421B45096DE0F`(`products`) USING BTREE,
  INDEX `FK622421B4840DA38F`(`specifications`) USING BTREE,
  CONSTRAINT `FK622421B45096DE0F` FOREIGN KEY (`products`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK622421B4840DA38F` FOREIGN KEY (`specifications`) REFERENCES `specification` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_specification
-- ----------------------------

-- ----------------------------
-- Table structure for product_specification_value
-- ----------------------------
DROP TABLE IF EXISTS `product_specification_value`;
CREATE TABLE `product_specification_value`  (
  `products` bigint(20) NOT NULL,
  `specification_values` bigint(20) NOT NULL,
  PRIMARY KEY (`products`, `specification_values`) USING BTREE,
  INDEX `FKBF71FF265096DE0F`(`products`) USING BTREE,
  INDEX `FKBF71FF2677BD1CD0`(`specification_values`) USING BTREE,
  CONSTRAINT `FKBF71FF265096DE0F` FOREIGN KEY (`products`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKBF71FF2677BD1CD0` FOREIGN KEY (`specification_values`) REFERENCES `specification_value` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_specification_value
-- ----------------------------

-- ----------------------------
-- Table structure for product_tag
-- ----------------------------
DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag`  (
  `products` bigint(20) NOT NULL,
  `tags` bigint(20) NOT NULL,
  PRIMARY KEY (`products`, `tags`) USING BTREE,
  INDEX `FK2F6A998B5096DE0F`(`products`) USING BTREE,
  INDEX `FK2F6A998BC842716F`(`tags`) USING BTREE,
  CONSTRAINT `FK2F6A998B5096DE0F` FOREIGN KEY (`products`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK2F6A998BC842716F` FOREIGN KEY (`tags`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_tag
-- ----------------------------

-- ----------------------------
-- Table structure for promotion
-- ----------------------------
DROP TABLE IF EXISTS `promotion`;
CREATE TABLE `promotion`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '起始日期',
  `end_date` datetime NULL DEFAULT NULL COMMENT '结束日期',
  `minimum_quantity` int(11) NULL DEFAULT NULL COMMENT '最小商品数量',
  `maximum_quantity` int(11) NULL DEFAULT NULL COMMENT '最大商品数量',
  `minimum_price` decimal(21, 6) NULL DEFAULT NULL COMMENT '最小商品价格',
  `maximum_price` decimal(21, 6) NULL DEFAULT NULL COMMENT '最大商品价格',
  `price_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '价格运算表达式',
  `point_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '积分运算表达式',
  `is_free_shipping` tinyint(1) NOT NULL COMMENT '是否免运费',
  `is_coupon_allowed` tinyint(1) NOT NULL COMMENT '是否允许使用优惠券',
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '介绍',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '促销' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_brand
-- ----------------------------
DROP TABLE IF EXISTS `promotion_brand`;
CREATE TABLE `promotion_brand`  (
  `promotions` bigint(20) NOT NULL,
  `brands` bigint(20) NOT NULL,
  PRIMARY KEY (`promotions`, `brands`) USING BTREE,
  INDEX `FKBD21C9ACA2AB700F`(`brands`) USING BTREE,
  INDEX `FKBD21C9AC682BD58F`(`promotions`) USING BTREE,
  CONSTRAINT `FKBD21C9AC682BD58F` FOREIGN KEY (`promotions`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKBD21C9ACA2AB700F` FOREIGN KEY (`brands`) REFERENCES `brand` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion_brand
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_coupon
-- ----------------------------
DROP TABLE IF EXISTS `promotion_coupon`;
CREATE TABLE `promotion_coupon`  (
  `promotions` bigint(20) NOT NULL,
  `coupons` bigint(20) NOT NULL,
  PRIMARY KEY (`promotions`, `coupons`) USING BTREE,
  INDEX `FKE8AB1EA1E538DDF7`(`coupons`) USING BTREE,
  INDEX `FKE8AB1EA1682BD58F`(`promotions`) USING BTREE,
  CONSTRAINT `FKE8AB1EA1682BD58F` FOREIGN KEY (`promotions`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKE8AB1EA1E538DDF7` FOREIGN KEY (`coupons`) REFERENCES `coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_gift
-- ----------------------------
DROP TABLE IF EXISTS `promotion_gift`;
CREATE TABLE `promotion_gift`  (
  `promotions` bigint(20) NOT NULL,
  `gifts` bigint(20) NOT NULL,
  PRIMARY KEY (`promotions`, `gifts`) USING BTREE,
  INDEX `ind_promotion_gift_gifts`(`gifts`) USING BTREE,
  CONSTRAINT `fk_promotion_gift_gift_p` FOREIGN KEY (`promotions`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_promotion_gift_gifts` FOREIGN KEY (`gifts`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion_gift
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_member_rank
-- ----------------------------
DROP TABLE IF EXISTS `promotion_member_rank`;
CREATE TABLE `promotion_member_rank`  (
  `promotions` bigint(20) NOT NULL,
  `member_ranks` bigint(20) NOT NULL,
  PRIMARY KEY (`promotions`, `member_ranks`) USING BTREE,
  INDEX `FKFF359916E24D908C`(`member_ranks`) USING BTREE,
  INDEX `FKFF359916682BD58F`(`promotions`) USING BTREE,
  CONSTRAINT `FKFF359916682BD58F` FOREIGN KEY (`promotions`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKFF359916E24D908C` FOREIGN KEY (`member_ranks`) REFERENCES `member_rank` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion_member_rank
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_product
-- ----------------------------
DROP TABLE IF EXISTS `promotion_product`;
CREATE TABLE `promotion_product`  (
  `promotions` bigint(20) NOT NULL,
  `products` bigint(20) NOT NULL,
  PRIMARY KEY (`promotions`, `products`) USING BTREE,
  INDEX `FKE12E55D45096DE0F`(`products`) USING BTREE,
  INDEX `FKE12E55D4682BD58F`(`promotions`) USING BTREE,
  CONSTRAINT `FKE12E55D45096DE0F` FOREIGN KEY (`products`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKE12E55D4682BD58F` FOREIGN KEY (`promotions`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion_product
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_product_category
-- ----------------------------
DROP TABLE IF EXISTS `promotion_product_category`;
CREATE TABLE `promotion_product_category`  (
  `promotions` bigint(20) NOT NULL COMMENT '促销Id',
  `product_categories` bigint(20) NOT NULL COMMENT '商品分类',
  PRIMARY KEY (`promotions`, `product_categories`) USING BTREE,
  INDEX `FK4A5AE7098C4C0635`(`product_categories`) USING BTREE,
  INDEX `FK4A5AE709682BD58F`(`promotions`) USING BTREE,
  CONSTRAINT `FK4A5AE709682BD58F` FOREIGN KEY (`promotions`) REFERENCES `promotion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK4A5AE7098C4C0635` FOREIGN KEY (`product_categories`) REFERENCES `product_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotion_product_category
-- ----------------------------

-- ----------------------------
-- Table structure for receiver
-- ----------------------------
DROP TABLE IF EXISTS `receiver`;
CREATE TABLE `receiver`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `consignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人',
  `area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区名称',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `zip_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮编',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认',
  `area_id` bigint(20) NULL DEFAULT NULL COMMENT '地区',
  `member_id` bigint(20) NOT NULL COMMENT '会员',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK22D1EC4E39A0DADE`(`area_id`) USING BTREE,
  INDEX `FK22D1EC4E7C62EDF8`(`member_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of receiver
-- ----------------------------
INSERT INTO `receiver` VALUES (1, '杨程', '广东省佛山市顺德区', '嘉信城市广场', '', '18148789239', 1, 1993, 510, '', '2021-02-22 15:12:12', '18148789239', '2021-02-22 15:12:12', 0);

-- ----------------------------
-- Table structure for refunds
-- ----------------------------
DROP TABLE IF EXISTS `refunds`;
CREATE TABLE `refunds`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `is_review` tinyint(1) NOT NULL COMMENT '是否审核通过',
  `method` int(11) NOT NULL COMMENT '方式',
  `payment_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '支付方式',
  `bank` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退款银行',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退款账号',
  `amount` decimal(21, 6) NOT NULL COMMENT '退款金额',
  `payee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收款人',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作员',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `order_id` bigint(20) NOT NULL COMMENT '订单',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `FKCFC4C5BCB992E8EF`(`order_id`) USING BTREE,
  CONSTRAINT `FKCFC4C5BCB992E8EF` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退款单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of refunds
-- ----------------------------

-- ----------------------------
-- Table structure for register_code
-- ----------------------------
DROP TABLE IF EXISTS `register_code`;
CREATE TABLE `register_code`  (
  `mobile` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接收短信的手机号码',
  `sms_code` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '短信内容',
  `op` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '短信类型',
  `expiration_date` datetime NULL DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`mobile`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of register_code
-- ----------------------------

-- ----------------------------
-- Table structure for returns
-- ----------------------------
DROP TABLE IF EXISTS `returns`;
CREATE TABLE `returns`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `shipping_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配送方式',
  `delivery_corp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `tracking_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运单号',
  `freight` decimal(21, 6) NULL DEFAULT NULL COMMENT '物流费用',
  `shipper` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发货人',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `zip_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮编',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作员',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `order_id` bigint(20) NOT NULL COMMENT '订单',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `FKD08A1F04B992E8EF`(`order_id`) USING BTREE,
  CONSTRAINT `FKD08A1F04B992E8EF` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退货单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of returns
-- ----------------------------

-- ----------------------------
-- Table structure for returns_item
-- ----------------------------
DROP TABLE IF EXISTS `returns_item`;
CREATE TABLE `returns_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `returns_id` bigint(20) NOT NULL COMMENT '退货单-关联returns',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKE830D76E21D01242`(`returns_id`) USING BTREE,
  CONSTRAINT `FKE830D76E21D01242` FOREIGN KEY (`returns_id`) REFERENCES `returns` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退货项' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of returns_item
-- ----------------------------

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `score` int(11) NOT NULL COMMENT '评分',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `is_show` tinyint(1) NOT NULL COMMENT '是否显示',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP',
  `member_id` bigint(20) NULL DEFAULT NULL COMMENT '会员',
  `product_id` bigint(20) NOT NULL COMMENT '商品',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9B6005777C62EDF8`(`member_id`) USING BTREE,
  INDEX `FK9B60057779F8D99A`(`product_id`) USING BTREE,
  CONSTRAINT `FK9B60057779F8D99A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK9B6005777C62EDF8` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '值',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统角色',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `value`(`value`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', 'R_ADMIN', '拥有最高后台管理权限', 1, NULL, '圣牧.管理员', '2016-05-05 16:55:13', '管理员', '2016-10-10 19:54:07', 0);
INSERT INTO `role` VALUES (2, '系统管理员', 'R_MANAGER', NULL, 0, NULL, '圣牧.管理员', '2016-05-13 10:44:34', '管理员', '2016-10-10 19:39:11', 0);
INSERT INTO `role` VALUES (3, '会员', 'R_MEMBER', NULL, 0, NULL, '圣牧.管理员', '2016-05-13 10:45:15', '管理员', '2016-10-10 19:56:15', 0);
INSERT INTO `role` VALUES (4, '普通用户', 'R_USER', '', 0, NULL, '圣牧.管理员', '2016-05-13 10:45:50', '聪明的竹子', '2020-10-15 09:30:09', 0);

-- ----------------------------
-- Table structure for seo
-- ----------------------------
DROP TABLE IF EXISTS `seo`;
CREATE TABLE `seo`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` int(11) NOT NULL COMMENT '类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面标题',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面关键词',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面描述',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'SEO设置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of seo
-- ----------------------------

-- ----------------------------
-- Table structure for shipping
-- ----------------------------
DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `shipping_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配送方式',
  `delivery_corp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物流公司',
  `delivery_corp_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流公司网址',
  `delivery_corp_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流公司代码',
  `tracking_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运单号',
  `freight` decimal(21, 6) NULL DEFAULT NULL COMMENT '物流费用',
  `consignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `zip_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮编',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作员',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `order_id` bigint(20) NOT NULL COMMENT '订单',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  INDEX `FK3440E00DB992E8EF`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发货单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipping
-- ----------------------------

-- ----------------------------
-- Table structure for shipping_item
-- ----------------------------
DROP TABLE IF EXISTS `shipping_item`;
CREATE TABLE `shipping_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `shipping_id` bigint(20) NOT NULL COMMENT '发货单',
  `is_delivery` tinyint(1) NOT NULL COMMENT '是否需要物流',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKCCE65405FF407320`(`shipping_id`) USING BTREE,
  CONSTRAINT `FKCCE65405FF407320` FOREIGN KEY (`shipping_id`) REFERENCES `shipping` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发货项' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipping_item
-- ----------------------------

-- ----------------------------
-- Table structure for shipping_method
-- ----------------------------
DROP TABLE IF EXISTS `shipping_method`;
CREATE TABLE `shipping_method`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `first_weight` int(11) NOT NULL COMMENT '首重量',
  `continue_weight` int(11) NOT NULL COMMENT '续重量',
  `first_price` decimal(21, 6) NOT NULL COMMENT '首重价格',
  `continue_price` decimal(21, 6) NOT NULL COMMENT '续重价格',
  `orders` int(11) NULL DEFAULT NULL COMMENT '订单',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'description',
  `default_delivery_corp_id` bigint(20) NULL DEFAULT NULL COMMENT '默认物流公司',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK32A8355346542319`(`default_delivery_corp_id`) USING BTREE,
  CONSTRAINT `FK32A8355346542319` FOREIGN KEY (`default_delivery_corp_id`) REFERENCES `delivery_corp` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配送方式' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipping_method
-- ----------------------------
INSERT INTO `shipping_method` VALUES (1, '普通快递', 1000, 1000, 0.000000, 0.000000, 1, 'http://localhost:8080/upload/image/express.gif', '系统将根据您的收货地址自动匹配快递公司进行配送，享受免运费服务', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `shipping_method` VALUES (2, '顺丰速递', 1000, 1000, 10.000000, 0.000000, 2, 'http://localhost:8080/upload/image/sf_express.gif', '需支付10元配送费用，不享受免运费服务', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `shipping_method` VALUES (3, '上门服务', 0, 0, 0.000000, 0.000000, 0, '/static/upload/image/202009/1892139c-7402-4fd6-a2fd-9445c95aa110-source.png', '', 1, '管理员', '2016-10-27 17:33:01', 'yangcheng', '2020-09-17 10:35:04', 0);

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `stock` int(11) NOT NULL COMMENT '库存',
  `allocated_stock` int(11) NOT NULL COMMENT '已分配库存',
  `cost` decimal(21, 6) NULL DEFAULT NULL COMMENT '成本价',
  `market_price` decimal(21, 6) NOT NULL COMMENT '市场价',
  `price` decimal(22, 6) NOT NULL COMMENT '售价',
  `exchange_point` bigint(20) NOT NULL COMMENT '兑换积分',
  `reward_point` bigint(20) NOT NULL COMMENT '赠送积分',
  `specification_values` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规格值',
  `product_id` bigint(20) NOT NULL COMMENT '商品',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认',
  `is_enable` tinyint(1) NOT NULL COMMENT '是否启用',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ind_Sku_product_id`(`product_id`) USING BTREE,
  INDEX `sku_sn`(`sn`) USING BTREE,
  CONSTRAINT `sku_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 189 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sku
-- ----------------------------
INSERT INTO `sku` VALUES (168, '358957543118077952', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-22 11:54:40', '', '2021-01-22 11:57:59', 1);
INSERT INTO `sku` VALUES (169, '358958373997117440', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-22 11:57:58', '', '2021-01-22 14:23:44', 1);
INSERT INTO `sku` VALUES (170, '358995055974809600', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-22 14:23:44', '', '2021-01-22 14:25:39', 1);
INSERT INTO `sku` VALUES (171, '358995538902777856', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-22 14:25:39', '', '2021-01-22 14:29:58', 1);
INSERT INTO `sku` VALUES (172, '358996624996827136', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-22 14:29:58', '', '2021-01-22 15:00:20', 1);
INSERT INTO `sku` VALUES (173, '359004266389569536', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-22 15:00:20', '', '2021-01-25 11:27:04', 1);
INSERT INTO `sku` VALUES (174, '360037759781437440', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 11:27:04', '', '2021-01-25 11:42:47', 1);
INSERT INTO `sku` VALUES (175, '360041714229968896', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 11:42:47', '', '2021-01-25 11:44:32', 1);
INSERT INTO `sku` VALUES (176, '360042155105845248', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 11:44:32', '', '2021-01-25 11:51:13', 1);
INSERT INTO `sku` VALUES (177, '360043835817984000', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 11:51:13', '', '2021-01-25 14:10:31', 1);
INSERT INTO `sku` VALUES (178, '360078893253656576', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 14:10:31', '', '2021-01-25 14:27:33', 1);
INSERT INTO `sku` VALUES (179, '360083180885114880', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 14:27:33', '', '2021-01-25 14:59:09', 1);
INSERT INTO `sku` VALUES (180, '360091132325003264', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 14:59:09', '', '2021-01-25 15:49:27', 1);
INSERT INTO `sku` VALUES (181, '360103788633128960', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 15:49:27', '', '2021-01-25 15:53:08', 1);
INSERT INTO `sku` VALUES (182, '360104716564168704', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 15:53:08', '', '2021-01-25 17:35:29', 1);
INSERT INTO `sku` VALUES (183, '360130474653253632', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-25 17:35:29', '', '2021-01-26 09:53:38', 1);
INSERT INTO `sku` VALUES (184, '360376634668220416', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-26 09:53:38', '', '2021-01-26 10:12:48', 1);
INSERT INTO `sku` VALUES (185, '360381457060855808', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-01-26 10:12:48', '', '2021-02-19 17:50:26', 1);
INSERT INTO `sku` VALUES (186, '369193934234058752', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-02-19 17:50:26', '', '2021-02-19 17:51:52', 1);
INSERT INTO `sku` VALUES (187, '369194295300718592', 100, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-02-19 17:51:52', '', '2021-02-19 18:05:55', 1);
INSERT INTO `sku` VALUES (188, '369197831119962112', 102, 0, 0.000000, 0.000000, 0.010000, 0, 0, ',', 432, 0, 0, '', '2021-02-19 18:05:55', '', '2021-03-10 15:40:37', 0);

-- ----------------------------
-- Table structure for sms
-- ----------------------------
DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '短信值',
  `type` int(11) NOT NULL COMMENT '短信类型',
  `expire_date` datetime NULL DEFAULT NULL COMMENT '过期日期',
  `used_date` datetime NULL DEFAULT NULL COMMENT '使用日期',
  `is_used` tinyint(1) NOT NULL COMMENT '是否已使用',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sms
-- ----------------------------
INSERT INTO `sms` VALUES (54, '18148789239', '1787', 0, NULL, NULL, 0, '', '2021-01-25 16:08:18', '', '2021-01-25 16:08:18');
INSERT INTO `sms` VALUES (55, '18148789239', '6700', 0, NULL, NULL, 0, '', '2021-01-25 16:09:01', '', '2021-01-25 16:09:01');
INSERT INTO `sms` VALUES (56, '18148789239', '6288', 0, NULL, NULL, 0, '', '2021-01-25 16:11:13', '', '2021-01-25 16:11:13');
INSERT INTO `sms` VALUES (57, '18148789239', '2481', 0, NULL, '2021-01-25 16:12:21', 1, '', '2021-01-25 16:12:12', '', '2021-01-25 16:12:21');
INSERT INTO `sms` VALUES (58, '18148789239', '6429', 0, NULL, '2021-01-25 16:13:16', 1, '', '2021-01-25 16:13:11', '', '2021-01-25 16:13:17');
INSERT INTO `sms` VALUES (59, '18148789239', '6884', 0, NULL, '2021-01-26 16:21:35', 1, '', '2021-01-26 16:21:29', '', '2021-01-26 16:21:35');
INSERT INTO `sms` VALUES (60, '18148789239', '6868', 0, NULL, '2021-02-19 17:52:53', 1, '', '2021-02-19 17:52:17', '', '2021-02-19 17:52:53');
INSERT INTO `sms` VALUES (61, '18148789239', '9959', 0, NULL, '2021-02-19 20:09:45', 1, '', '2021-02-19 20:09:33', '', '2021-02-19 20:09:45');
INSERT INTO `sms` VALUES (62, '18148789239', '7310', 0, NULL, '2021-02-22 11:16:32', 1, '', '2021-02-22 11:16:26', '', '2021-02-22 11:16:32');
INSERT INTO `sms` VALUES (63, '18148789239', '3150', 0, NULL, '2021-02-24 14:33:47', 1, '', '2021-02-24 14:33:42', '', '2021-02-24 14:33:47');
INSERT INTO `sms` VALUES (64, '18148789239', '0068', 0, NULL, '2021-02-24 14:39:31', 1, '', '2021-02-24 14:39:15', '', '2021-02-24 14:39:31');
INSERT INTO `sms` VALUES (65, '18148789239', '4522', 0, NULL, '2021-02-24 15:15:45', 1, '', '2021-02-24 15:15:41', '', '2021-02-24 15:15:45');
INSERT INTO `sms` VALUES (66, '18148789239', '0132', 0, NULL, '2021-02-24 15:16:46', 1, '', '2021-02-24 15:16:41', '', '2021-02-24 15:16:46');
INSERT INTO `sms` VALUES (67, '18148789239', '8394', 0, NULL, '2021-02-25 16:58:42', 1, '', '2021-02-25 16:58:37', '', '2021-02-25 16:58:42');
INSERT INTO `sms` VALUES (68, '18148789239', '0257', 0, NULL, '2021-02-26 15:39:10', 1, '', '2021-02-26 15:39:04', '', '2021-02-26 15:39:10');
INSERT INTO `sms` VALUES (69, '18148789239', '9447', 0, NULL, '2021-02-26 15:40:58', 1, '', '2021-02-26 15:40:55', '', '2021-02-26 15:40:58');
INSERT INTO `sms` VALUES (70, '18148789239', '3238', 0, NULL, '2021-03-01 09:24:07', 1, '', '2021-03-01 09:24:03', '', '2021-03-01 09:24:07');
INSERT INTO `sms` VALUES (71, '18148789239', '9086', 0, NULL, '2021-03-10 15:28:08', 1, '', '2021-03-10 15:28:03', '', '2021-03-10 15:28:08');

-- ----------------------------
-- Table structure for sn
-- ----------------------------
DROP TABLE IF EXISTS `sn`;
CREATE TABLE `sn`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` int(11) NOT NULL COMMENT '类型',
  `last_value` bigint(20) NOT NULL COMMENT '末值',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` bit(1) NOT NULL DEFAULT b'0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '序列号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sn
-- ----------------------------
INSERT INTO `sn` VALUES (1, 0, 68, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sn` VALUES (2, 1, 255, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sn` VALUES (3, 2, 49, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sn` VALUES (4, 3, 6, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sn` VALUES (5, 4, 8, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sn` VALUES (6, 5, 5, NULL, NULL, NULL, NULL, b'0');

-- ----------------------------
-- Table structure for specification
-- ----------------------------
DROP TABLE IF EXISTS `specification`;
CREATE TABLE `specification`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `product_category_id` bigint(20) NOT NULL COMMENT '绑定分类',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规格' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of specification
-- ----------------------------

-- ----------------------------
-- Table structure for specification_value
-- ----------------------------
DROP TABLE IF EXISTS `specification_value`;
CREATE TABLE `specification_value`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `specification_id` bigint(20) NOT NULL COMMENT '规格',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK5E624376629A04C2`(`specification_id`) USING BTREE,
  CONSTRAINT `FK5E624376629A04C2` FOREIGN KEY (`specification_id`) REFERENCES `specification` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规格值' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of specification_value
-- ----------------------------

-- ----------------------------
-- Table structure for stock_log
-- ----------------------------
DROP TABLE IF EXISTS `stock_log`;
CREATE TABLE `stock_log`  (
  `id` bigint(29) NOT NULL AUTO_INCREMENT COMMENT '主键_id',
  `in_quantity` int(11) NOT NULL COMMENT '入库数量',
  `out_quantity` int(11) NOT NULL COMMENT '出库数量',
  `stock` int(11) NOT NULL COMMENT '当前库存',
  `sku_id` bigint(20) NOT NULL COMMENT 'SKU',
  `type` int(11) NOT NULL COMMENT '类型',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `stock_log_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_log
-- ----------------------------
INSERT INTO `stock_log` VALUES (1, 0, 1, 101, 188, 0, '', '18148789239', '2021-03-10 11:12:38', '', '2021-03-10 11:12:38', 0);
INSERT INTO `stock_log` VALUES (2, 0, 1, 102, 188, 0, '', '18148789239', '2021-03-10 15:40:37', '', '2021-03-10 15:40:37', 0);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `type` int(11) NOT NULL COMMENT '类型',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `orders` int(11) NULL DEFAULT NULL COMMENT '排序',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `creation_date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `last_updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `last_updated_date` datetime NULL DEFAULT NULL COMMENT '最后修改日期',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
