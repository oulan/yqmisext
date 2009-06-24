unit uMWICIntf;

interface

// 此处开始为明华IC 4442卡接口函数
// 开发其它使用4442卡的接口可以使用这段代码
const mwicintf = 'MWIC_32.DLL';
//  operate sle 4442
function swr_4442(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
far;external mwicintf name 'swr_4442';
function srd_4442(icdev: longint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
far;external mwicintf name 'srd_4442';
function prd_4442(icdev: longint;length:smallint;data1:pchar):smallint;stdcall;
far;external mwicintf name 'prd_4442';
function pwr_4442(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
far;external mwicintf name 'pwr_4442';
function chk_4442(icdev: longint):smallint;stdcall;
far;external mwicintf name 'chk_4442';

function csc_4442(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external mwicintf name 'csc_4442';
function wsc_4442(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external mwicintf name 'wsc_4442';
function rsc_4442(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external mwicintf name 'rsc_4442';
function rsct_4442(icdev: longint;counter:pchar):smallint;stdcall;
far;external mwicintf name 'rsct_4442';

  //use general function
  function ic_init(port: smallint;baud:longint): longint; stdcall;
  far;external mwicintf name 'ic_init';
  function auto_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'auto_init';
  function ic_exit(icdev: longint):smallint;stdcall;
  far;external mwicintf  name 'ic_exit';
  function get_status(icdev: longint;status:pchar):smallint;stdcall;
  far;external mwicintf  name 'get_status';

  function cmp_dvsc(icdev:longint;length:smallint;password:pchar):smallint;stdcall;
  far;external mwicintf  name 'cmp_dvsc';
  function setsc_md(icdev: longint;mode:smallint):smallint;stdcall;
  far;external mwicintf name 'setsc_md';
  function srd_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
  far;external mwicintf name 'srd_dvsc'
  function swr_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
  far;external mwicintf name 'swr_dvsc';

  function turn_off(icdev: longint):smallint;stdcall;
  far;external mwicintf name 'turn_off';
  function turn_on(icdev: longint):smallint;stdcall;
  far;external mwicintf name 'turn_on';
  function auto_pull(icdev: longint):smallint;stdcall;
  far;external mwicintf name 'auto_pull';
  function srd_ver(icdev: longint;length:smallint;ver:pchar):smallint;stdcall;
  far;external mwicintf name 'srd_ver';
  function dv_beep(icdev: longint;time:smallint):smallint;stdcall;
  far;external mwicintf name 'dv_beep';

  function asc_hex(asc:pchar;hex:pchar;len:smallint):smallint;stdcall;
  far;external mwicintf name 'asc_hex';
  function hex_asc(hex:pchar;asc:pchar;len:smallint):smallint;stdcall;
  far;external mwicintf name 'hex_asc';

  function ic_encrypt(key:pchar;source:pchar;len:smallint;dest:pchar):smallint;
  stdcall;far;external mwicintf name 'ic_encrypt';
  function ic_decrypt(key:pchar;dest:pchar;len:smallint;source:pchar):smallint;
  stdcall;far;external mwicintf name 'ic_decrypt';

implementation

end.
 