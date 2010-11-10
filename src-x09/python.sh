#!/bin/sh

RETVAL=0
QPKG_ROOTFS=/mnt/HDA_ROOT/rootfs_2_3_6
QPKG_BASE=

if [ `/sbin/getcfg Python Enable -u -d FALSE -f /etc/config/qpkg.conf` = UNKNOWN ]; then
	/sbin/setcfg Python Enable TRUE -f /etc/config/qpkg.conf
elif [ `/sbin/getcfg Python Enable -u -d FALSE -f /etc/config/qpkg.conf` != TRUE ]; then
	echo "Python is disabled."
fi
  
find_base(){
# Determine BASE installation location according to smb.conf
publicdir=`/sbin/getcfg Public path -f /etc/config/smb.conf`
if [ ! -z $publicdir ] && [ -d $publicdir ];then
        publicdirp1=`/bin/echo $publicdir | /bin/cut -d "/" -f 2`
        publicdirp2=`/bin/echo $publicdir | /bin/cut -d "/" -f 3`
        publicdirp3=`/bin/echo $publicdir | /bin/cut -d "/" -f 4`
        if [ ! -z $publicdirp1 ] && [ ! -z $publicdirp2 ] && [ ! -z $publicdirp3 ]; then
                [ -d "/${publicdirp1}/${publicdirp2}/Public" ] && QPKG_BASE="/${publicdirp1}/${publicdirp2}"
        fi
fi

# Determine BASE installation location by checking where the Public folder is.
if [ -z $QPKG_BASE ]; then
        for datadirtest in /share/HDA_DATA /share/HDB_DATA /share/HDC_DATA /share/HDD_DATA /share/MD0_DATA /share/MD1_DATA; do
                [ -d $datadirtest/Public ] && QPKG_BASE="/${publicdirp1}/${publicdirp2}"
        done
fi
if [ -z $QPKG_BASE ] ; then
        /bin/echo "The Public share not found."
        _exit 1
fi


}

case "$1" in
  start)  	
	/bin/echo "Re-linking Python files... "
	find_base	
	QPKG_DIR="${QPKG_BASE}/.qpkg/Python"
#create symbolic links	 				
	/bin/ln -sf ${QPKG_DIR}/bin/2to3 ${QPKG_ROOTFS}/usr/bin/2to3
	/bin/ln -sf ${QPKG_DIR}/bin/idle ${QPKG_ROOTFS}/usr/bin/idle                         
	/bin/ln -sf ${QPKG_DIR}/bin/pydoc ${QPKG_ROOTFS}/usr/bin/pydoc                       
	/bin/ln -sf ${QPKG_DIR}/bin/python2.7-config ${QPKG_ROOTFS}/usr/bin/python-config          
	/bin/ln -sf ${QPKG_DIR}/bin/python2.7 ${QPKG_ROOTFS}/usr/bin/python2.7                     
	/bin/ln -sf ${QPKG_DIR}/bin/python2.7-config ${QPKG_ROOTFS}/usr/bin/python2.7-config       
	/bin/ln -sf ${QPKG_DIR}/bin/smtpd.py ${QPKG_ROOTFS}/usr/bin/smtpd.py                 
	/bin/ln -sf ${QPKG_DIR}/bin/python ${QPKG_ROOTFS}/usr/bin/python                        
				                                                                                     
	/bin/ln -sf ${QPKG_DIR}/lib/python2.7 ${QPKG_ROOTFS}/usr/lib/python2.7                     
				                                                                                     
	/bin/mkdir -p ${QPKG_ROOTFS}/usr/include                                                   
	/bin/ln -sf ${QPKG_DIR}/include/python2.7 ${QPKG_ROOTFS}/usr/include/python2.7             

	/bin/ln -sf ${QPKG_DIR}/bin/2to3 /usr/bin/2to3
	/bin/ln -sf ${QPKG_DIR}/bin/idle /usr/bin/idle
	/bin/ln -sf ${QPKG_DIR}/bin/pydoc /usr/bin/pydoc
	/bin/ln -sf ${QPKG_DIR}/bin/python2.7-config /usr/bin/python-config
	/bin/ln -sf ${QPKG_DIR}/bin/python2.7 /usr/bin/python2.7
	/bin/ln -sf ${QPKG_DIR}/bin/python2.7-config /usr/bin/python2.7-config
	/bin/ln -sf ${QPKG_DIR}/bin/smtpd.py /usr/bin/smtpd.py
	/bin/ln -sf ${QPKG_DIR}/bin/python /usr/bin/python
				
	/bin/ln -sf ${QPKG_DIR}/lib/python2.7 /usr/lib/python2.7
				
	/bin/mkdir -p /usr/include
	/bin/ln -sf ${QPKG_DIR}/include/python2.7 /usr/include/python2.7
	
	RETVAL=$?
	/bin/sleep 5
	;;
  stop)
	/bin/echo "Removing Python file links... "
	find_base	
#remove symbolic links	 	
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/2to3
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/idle
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/pydoc
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python-config
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python2.7
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python2.7-config
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/smtpd.py
	/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python
				
	/bin/rm -rf ${QPKG_ROOTFS}/usr/lib/python2.7
				
	/bin/rm -rf ${QPKG_ROOTFS}/usr/include/python2.7
			
	/bin/rm -rf /usr/bin/idle
	/bin/rm -rf /usr/bin/pydoc
	/bin/rm -rf /usr/bin/python-config
	/bin/rm -rf /usr/bin/python2.7
	/bin/rm -rf /usr/bin/python2.7-config
	/bin/rm -rf /usr/bin/smtpd.py
	/bin/rm -rf /usr/bin/python
				
	/bin/rm -rf /usr/lib/python2.7
				
	/bin/rm -rf /usr/include/python2.7
	RETVAL=$?
  /bin/sleep 3
	;;
  restart)
	$0 stop
	$0 start
	RETVAL=$?
	;;
  *)
	/bin/echo "Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $RETVAL

