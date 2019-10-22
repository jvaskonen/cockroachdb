# == Class cockroach::service
#
# This class is called from the cockroachdb class to configure the service.
#
#
class cockroachdb::service {

  $cockroachdb_hash = {
    'description'      => $cockroachdb::description,
    'workingdirectory' => $cockroachdb::workingdirectory,
    'node1ip'          => $cockroachdb::node1ip,
    'node2ip'          => $cockroachdb::node2ip,
    'node3ip'          => $cockroachdb::node3ip,
    'cache'            => $cockroachdb::cache,
    'maxsqlmemory'     => $cockroachdb::maxsqlmemory,
    'timeoutstopsec'   => $cockroachdb::timeoutstopsec,
    'restart'          => $cockroachdb::restart,
    'restartsec'       => $cockroachdb::restartsec,
    'standardoutput'   => $cockroachdb::standardoutput,
    'standarderror'    => $cockroachdb::standarderror,
    'syslogidentifier' => $cockroachdb::syslogidentifier,
    'user'             => $cockroachdb::user,
    'additionalparams' => $cockroachdb::additional_params,
  }

  file { '/etc/systemd/system/cockroachdb.service':
    ensure  => file,
    content => epp('cockroachdb/cockroachdb.service.epp', $cockroachdb_hash),
    notify  => Service['cockroachdb'],
  }
  service { 'cockroachdb':
    ensure => 'running',
  }
}