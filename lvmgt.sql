-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2019 at 11:27 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lvmgt`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `lvapprove_Data` ()  BEGIN
    DECLARE
        v_email VARCHAR(100) ; DECLARE v_count INT DEFAULT 0 ;  DECLARE c2 CURSOR FOR
    SELECT
        useremail
    FROM
        approle
    WHERE
        compid = compId AND doctype = 'CL' AND deptid = deptId ; 

SELECT
        COUNT(*)
    INTO v_count
FROM
    approle
WHERE
    compid = compId AND doctype = 'CL' AND deptid = deptId ;

OPEN c2 ;
     igmLoop: LOOP FETCH c2
INTO v_email ; WHILE v_count > 0
DO
INSERT INTO leaveapr(
    docno,
    compid,
    deptid,
    useremail,
    leavefrom,
    leaveto,
    lvstatus,
    altuser,
    leavestay,
    leavephone1,
    leavephone2,
    refdocno,
    leavecause
)
VALUES(
    fn_docno(100, 'CLA'),
    100,
    10,
    'probir1@just.edu.bd',
    '2019/10/27',
    '2019/10/28',
    'not_apr',
    v_email,
    'Dhaka',
    '2222',
    '2223',
    '11000',
    'sickness'
) ;
SET
    v_count = v_count -1 ;
END WHILE ;
END LOOP igmLoop ; CLOSE c2 ;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_docno` (`comp_id` INT(3), `doc_type` VARCHAR(20)) RETURNS VARCHAR(20) CHARSET latin1 BEGIN
    DECLARE present_value varchar(10);
 
    select concat(doc_type,LPAD(docno, 6, 0)) 
    INTO	present_value
    from document 
    where document.compid = comp_id and document.doctype = doc_type;
    
    UPDATE document
    set docno = docno + 1
    where document.compid = comp_id and document.doctype = doc_type;
    
    RETURN (present_value);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_username` (`v_email` VARCHAR(100)) RETURNS VARCHAR(100) CHARSET latin1 BEGIN
declare v_username varchar(100) DEFAULT ''; 

select username
into v_username
from user
where useremail = v_email; 

return (v_username);

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `approle`
--

CREATE TABLE `approle` (
  `compid` int(3) DEFAULT NULL,
  `deptid` int(3) DEFAULT NULL,
  `useremail` varchar(100) DEFAULT NULL,
  `doctype` varchar(20) DEFAULT NULL,
  `position` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approle`
--

INSERT INTO `approle` (`compid`, `deptid`, `useremail`, `doctype`, `position`) VALUES
(100, 10, 'ictcelladmin@just.edu.bd', 'CL', 2),
(100, 10, 'rh.sawan@just.edu.bd', 'CL', 1);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `compid` int(3) NOT NULL,
  `compname` varchar(100) NOT NULL,
  `compadd` varchar(255) NOT NULL,
  `compweb` varchar(50) NOT NULL,
  `compemail` varchar(100) DEFAULT NULL,
  `compphone1` varchar(20) DEFAULT NULL,
  `compphone2` varchar(20) DEFAULT NULL,
  `compfax` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`compid`, `compname`, `compadd`, `compweb`, `compemail`, `compphone1`, `compphone2`, `compfax`) VALUES
(100, 'Jashore University of Science and Technology', 'Jasshore University of Science and Technology, Jashore-7400', 'www.just.edu.bd', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `compid` int(3) NOT NULL,
  `deptid` int(3) NOT NULL,
  `deptname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`compid`, `deptid`, `deptname`) VALUES
(100, 10, 'ICT Cell');

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `compid` int(3) DEFAULT NULL,
  `doctype` varchar(20) NOT NULL,
  `doctypename` varchar(100) DEFAULT NULL,
  `docno` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`compid`, `doctype`, `doctypename`, `docno`) VALUES
(100, 'CL', 'Casual Leave', 1),
(100, 'CLA', 'Casual Leave Approve', 1),
(100, 'TSK', 'Task', 9);

-- --------------------------------------------------------

--
-- Table structure for table `form`
--

CREATE TABLE `form` (
  `compid` int(3) NOT NULL,
  `frmname` varchar(100) NOT NULL,
  `frmdetail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form`
--

INSERT INTO `form` (`compid`, `frmname`, `frmdetail`) VALUES
(100, 'lvapply', 'Casual Leave Apply Form'),
(100, 'profile', 'Profile'),
(100, 'task', 'Task Assign');

-- --------------------------------------------------------

--
-- Table structure for table `formaccess`
--

CREATE TABLE `formaccess` (
  `compid` int(3) NOT NULL,
  `deptid` int(3) NOT NULL,
  `frmname` varchar(100) NOT NULL,
  `useremail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `formaccess`
--

INSERT INTO `formaccess` (`compid`, `deptid`, `frmname`, `useremail`) VALUES
(100, 10, 'lvapply', 'farid1@just.edu.bd'),
(100, 10, 'lvapply', 'ictcelladmin@just.edu.bd'),
(100, 10, 'lvapply', 'probir1@just.edu.bd'),
(100, 10, 'lvapply', 'rh.sawan@just.edu.bd'),
(100, 10, 'profile', 'farid1@just.edu.bd'),
(100, 10, 'profile', 'ictcelladmin@just.edu.bd'),
(100, 10, 'profile', 'probir1@just.edu.bd'),
(100, 10, 'profile', 'rh.sawan@just.edu.bd'),
(100, 10, 'task', 'rh.sawan@just.edu.bd');

-- --------------------------------------------------------

--
-- Table structure for table `leaveapply`
--

CREATE TABLE `leaveapply` (
  `docno` varchar(10) NOT NULL,
  `compid` int(3) DEFAULT NULL,
  `deptid` int(3) DEFAULT NULL,
  `useremail` varchar(100) DEFAULT NULL,
  `leavefrom` date DEFAULT NULL,
  `leaveto` date DEFAULT NULL,
  `leaveduration` int(3) DEFAULT NULL,
  `lvstatus` varchar(20) DEFAULT NULL,
  `date_time` date DEFAULT current_timestamp(),
  `altuser` varchar(100) DEFAULT NULL,
  `leavestay` varchar(255) DEFAULT NULL,
  `leavephone1` varchar(20) DEFAULT NULL,
  `leavephone2` varchar(20) DEFAULT NULL,
  `refdocno` varchar(20) DEFAULT NULL,
  `leavecause` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `leaveapply`
--
DELIMITER $$
CREATE TRIGGER `tgr_lvapply` BEFORE INSERT ON `leaveapply` FOR EACH ROW BEGIN
		DECLARE v_docno varchar(10);
        
        select fn_docno(NEW.compid, 'CL')
        into v_docno
        from dual;
        
        SET NEW.docno = v_docno;
        
    	    call `lvapprove_Data`();
  

    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `leaveapr`
--

CREATE TABLE `leaveapr` (
  `docno` varchar(10) NOT NULL,
  `compid` int(3) DEFAULT NULL,
  `deptid` int(3) DEFAULT NULL,
  `useremail` varchar(100) DEFAULT NULL,
  `leavefrom` date DEFAULT NULL,
  `leaveto` date DEFAULT NULL,
  `leaveduration` int(3) DEFAULT NULL,
  `lvstatus` varchar(20) DEFAULT NULL,
  `date_time` date DEFAULT current_timestamp(),
  `altuser` varchar(100) DEFAULT NULL,
  `leavestay` varchar(255) DEFAULT NULL,
  `leavephone1` varchar(20) DEFAULT NULL,
  `leavephone2` varchar(20) DEFAULT NULL,
  `refdocno` varchar(20) DEFAULT NULL,
  `leavecause` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `leavemaster`
--

CREATE TABLE `leavemaster` (
  `compid` int(3) DEFAULT NULL,
  `deptid` int(3) DEFAULT NULL,
  `useremail` varchar(100) DEFAULT NULL,
  `doctype` varchar(20) DEFAULT NULL,
  `leaveamt` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leavemaster`
--

INSERT INTO `leavemaster` (`compid`, `deptid`, `useremail`, `doctype`, `leaveamt`) VALUES
(100, 10, 'rh.sawan@just.edu.bd', 'CL', 20),
(100, 10, 'probir1@just.edu.bd', 'CL', 20);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task`
--

CREATE TABLE `tbl_task` (
  `compid` int(3) DEFAULT NULL,
  `deptid` int(3) DEFAULT NULL,
  `docno` varchar(20) NOT NULL,
  `tasktitle` varchar(255) DEFAULT NULL,
  `taskuser` varchar(100) DEFAULT NULL,
  `date_time` date DEFAULT current_timestamp(),
  `status` varchar(100) DEFAULT 'Pending',
  `taskassign` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_task`
--

INSERT INTO `tbl_task` (`compid`, `deptid`, `docno`, `tasktitle`, `taskuser`, `date_time`, `status`, `taskassign`) VALUES
(100, 10, 'TSK000006', 'Room: 532, Dept: Chemistry, Academic Building. Need four new connection', 'probir@just.edu.bd', '2019-10-21', 'Pending', 'rh.sawan@just.edu.bd'),
(100, 10, 'TSK000007', 'test task', 'probir1@just.edu.bd', '2019-10-22', 'Done', 'rh.sawan@just.edu.bd');

--
-- Triggers `tbl_task`
--
DELIMITER $$
CREATE TRIGGER `tgr_task` BEFORE INSERT ON `tbl_task` FOR EACH ROW BEGIN
	set NEW.docno = fn_docno(NEW.compid, 'TSK');
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_comment`
--

CREATE TABLE `tbl_task_comment` (
  `id` int(11) NOT NULL,
  `compid` int(3) DEFAULT NULL,
  `deptid` int(3) DEFAULT NULL,
  `docno` varchar(20) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `com_user` varchar(100) DEFAULT NULL,
  `date_time` varchar(50) DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_task_comment`
--

INSERT INTO `tbl_task_comment` (`id`, `compid`, `deptid`, `docno`, `comment`, `com_user`, `date_time`) VALUES
(2, 100, 10, 'TSK000006', 'Probir Kukar Adhikari -->number of point one but user 4 for this reason need wifi router', 'probir@just.edu.bd', '2019-10-22'),
(3, 100, 10, 'TSK000006', 'Md. Rakibul Hassan -->welcome', 'rh.sawan@just.edu.bd', '2019-10-22'),
(4, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->Thank you', 'rh.sawan@just.edu.bd', '2019-10-22'),
(5, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->hi', 'rh.sawan@just.edu.bd', '2019-10-22'),
(6, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->welcome', 'rh.sawan@just.edu.bd', '2019-10-22'),
(7, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->Thank you', 'rh.sawan@just.edu.bd', '2019-10-22'),
(8, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->Thank you', 'rh.sawan@just.edu.bd', '2019-10-22'),
(9, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->Thank you', 'rh.sawan@just.edu.bd', '2019-10-22'),
(10, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->Thank you', 'rh.sawan@just.edu.bd', '2019-10-22'),
(11, 100, 10, 'TSK000007', 'Md. Rakibul Hassan -->Thank you', 'rh.sawan@just.edu.bd', '2019-10-22');

--
-- Triggers `tbl_task_comment`
--
DELIMITER $$
CREATE TRIGGER `tgr_tbl_tskcom_update` BEFORE UPDATE ON `tbl_task_comment` FOR EACH ROW BEGIN
	declare v_date_time date; 
	select sysdate() 
    into v_date_time
    from dual; 
    
	set NEW.date_time = v_date_time; 
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tgr_tbl_tskcomment` BEFORE INSERT ON `tbl_task_comment` FOR EACH ROW BEGIN
	declare v_date_time date; 
    DECLARE v_comment varchar(2500);
    
	SELECT DATE_FORMAT(SYSDATE(), '%Y-%m-%d %h-%m-%s')
    into v_date_time
    from dual; 
    
    select concat(concat(concat(fn_username(NEW.com_user), ' '), '-->'), NEW.comment)
    into v_comment
    from dual; 
    
	set NEW.date_time = v_date_time; 
    set NEW.comment = v_comment; 
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `compid` int(3) NOT NULL,
  `deptid` int(3) NOT NULL,
  `username` varchar(100) NOT NULL,
  `useremail` varchar(100) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `userphone1` varchar(20) DEFAULT NULL,
  `userphone2` varchar(20) DEFAULT NULL,
  `userperadd` varchar(255) DEFAULT NULL,
  `userpreadd` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`compid`, `deptid`, `username`, `useremail`, `designation`, `userphone1`, `userphone2`, `userperadd`, `userpreadd`, `signature`, `image`) VALUES
(100, 10, 'Mr. Farid', 'farid1@just.edu.bd', 'Data Entry Operator', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 10, 'Mr. Admin of ICT Cell', 'ictcelladmin@just.edu.bd', 'Admin', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 10, 'Probir Kumar Adhikari', 'probir1@just.edu.bd', 'Network Technician', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 10, 'Probir Kukar Adhikari', 'probir@just.edu.bd', 'Network Technician', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 10, 'Md. Rakibul Hassan', 'rh.sawan@just.edu.bd', 'Assistant Network Engineer', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `approle`
--
ALTER TABLE `approle`
  ADD UNIQUE KEY `uk_approle` (`compid`,`deptid`,`useremail`,`doctype`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`compid`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`deptid`),
  ADD KEY `fk_dept_comp` (`compid`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`doctype`),
  ADD UNIQUE KEY `uk_document` (`compid`,`doctype`);

--
-- Indexes for table `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`frmname`),
  ADD KEY `fk_form_comp` (`compid`);

--
-- Indexes for table `formaccess`
--
ALTER TABLE `formaccess`
  ADD UNIQUE KEY `uk_formaccess` (`compid`,`frmname`,`useremail`);

--
-- Indexes for table `leaveapply`
--
ALTER TABLE `leaveapply`
  ADD PRIMARY KEY (`docno`);

--
-- Indexes for table `leaveapr`
--
ALTER TABLE `leaveapr`
  ADD PRIMARY KEY (`docno`);

--
-- Indexes for table `leavemaster`
--
ALTER TABLE `leavemaster`
  ADD UNIQUE KEY `uk_leavemaster` (`compid`,`deptid`,`useremail`,`doctype`),
  ADD KEY `fk_lvmstr_dept` (`deptid`);

--
-- Indexes for table `tbl_task`
--
ALTER TABLE `tbl_task`
  ADD PRIMARY KEY (`docno`);

--
-- Indexes for table `tbl_task_comment`
--
ALTER TABLE `tbl_task_comment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD UNIQUE KEY `UC_Users` (`compid`,`useremail`),
  ADD KEY `fk_user_dept` (`deptid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_task_comment`
--
ALTER TABLE `tbl_task_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_dept_comp` FOREIGN KEY (`compid`) REFERENCES `company` (`compid`);

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `fk_doc_comp` FOREIGN KEY (`compid`) REFERENCES `company` (`compid`);

--
-- Constraints for table `form`
--
ALTER TABLE `form`
  ADD CONSTRAINT `fk_form_comp` FOREIGN KEY (`compid`) REFERENCES `company` (`compid`);

--
-- Constraints for table `leavemaster`
--
ALTER TABLE `leavemaster`
  ADD CONSTRAINT `fk_lvmstr_comp` FOREIGN KEY (`compid`) REFERENCES `department` (`compid`),
  ADD CONSTRAINT `fk_lvmstr_dept` FOREIGN KEY (`deptid`) REFERENCES `department` (`deptid`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_comp` FOREIGN KEY (`compid`) REFERENCES `company` (`compid`),
  ADD CONSTRAINT `fk_user_dept` FOREIGN KEY (`deptid`) REFERENCES `department` (`deptid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
