SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Table `flisol`.`perfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `flisol`.`perfil` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flisol`.`uf`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `flisol`.`uf` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flisol`.`usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `flisol`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(200) NOT NULL ,
  `senha` CHAR(32) NOT NULL ,
  `dt_cadastro` DATETIME NOT NULL ,
  `cpf` CHAR(14) NOT NULL ,
  `cep` CHAR(9) NULL ,
  `cidade` VARCHAR(45) NULL ,
  `site` VARCHAR(45) NULL ,
  `perfil_id` INT NOT NULL ,
  `uf_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_usuario_perfil1` (`perfil_id` ASC) ,
  INDEX `fk_usuario_uf1` (`uf_id` ASC) ,
  CONSTRAINT `fk_usuario_perfil1`
    FOREIGN KEY (`perfil_id` )
    REFERENCES `flisol`.`perfil` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_uf1`
    FOREIGN KEY (`uf_id` )
    REFERENCES `flisol`.`uf` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flisol`.`sala`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `flisol`.`sala` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NULL ,
  `bloco` VARCHAR(4) NULL ,
  `complemento` VARCHAR(45) NULL ,
  `qt_pessoas` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flisol`.`atividade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `flisol`.`atividade` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_palestrante` INT NOT NULL ,
  `id_sala` INT NOT NULL ,
  `nome` VARCHAR(45) NOT NULL ,
  `descricao` VARCHAR(200) NOT NULL ,
  `dt_cadastro` DATETIME NOT NULL ,
  `situacao` CHAR(1) NOT NULL ,
  `qt_horas` TIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_atividade_usuario1` (`id_palestrante` ASC) ,
  INDEX `fk_atividade_sala1` (`id_sala` ASC) ,
  CONSTRAINT `fk_atividade_usuario1`
    FOREIGN KEY (`id_palestrante` )
    REFERENCES `flisol`.`usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atividade_sala1`
    FOREIGN KEY (`id_sala` )
    REFERENCES `flisol`.`sala` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flisol`.`inscricao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `flisol`.`inscricao` (
  `id_atividade` INT NOT NULL AUTO_INCREMENT ,
  `id_usuario` INT NOT NULL ,
  `dt_cadastro` DATETIME NOT NULL ,
  `presenca` VARCHAR(45) NOT NULL DEFAULT 'false' ,
  PRIMARY KEY (`id_atividade`, `id_usuario`) ,
  INDEX `fk_atividade_has_usuario_atividade` (`id_atividade` ASC) ,
  INDEX `fk_atividade_has_usuario_usuario1` (`id_usuario` ASC) ,
  CONSTRAINT `fk_atividade_has_usuario_atividade`
    FOREIGN KEY (`id_atividade` )
    REFERENCES `flisol`.`atividade` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atividade_has_usuario_usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `flisol`.`usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
