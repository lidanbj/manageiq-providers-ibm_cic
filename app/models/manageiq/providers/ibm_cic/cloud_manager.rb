ManageIQ::Providers::Openstack::CloudManager.include(ActsAsStiLeafClass)

class ManageIQ::Providers::IbmCic::CloudManager < ManageIQ::Providers::Openstack::CloudManager
  require_nested :AuthKeyPair
  require_nested :AvailabilityZone
  require_nested :AvailabilityZoneNull
  require_nested :CloudResourceQuota
  require_nested :CloudTenant
  require_nested :EventCatcher
  require_nested :Flavor
  require_nested :HostAggregate
  require_nested :MetricsCapture
  require_nested :MetricsCollectorWorker
  require_nested :OrchestrationStack
  require_nested :Refresher
  require_nested :RefreshWorker
  require_nested :Template
  require_nested :Vm

  supports :create

  def self.vm_vendor
    "ibm_z_vm"
  end

  def self.ems_type
    @ems_type ||= "ibm_cic".freeze
  end

  def self.description
    @description ||= "IBM Cloud Infrastructure Center".freeze
  end

  has_one :network_manager,
          :foreign_key => :parent_ems_id,
          :class_name  => "ManageIQ::Providers::IbmCic::NetworkManager",
          :autosave    => true,
          :dependent   => :destroy
  has_one :cinder_manager,
          :foreign_key => :parent_ems_id,
          :class_name  => "ManageIQ::Providers::IbmCic::StorageManager::CinderManager",
          :dependent   => :destroy,
          :inverse_of  => :parent_manager,
          :autosave    => true

  def image_name
    "ibm_cic"
  end

  def ensure_swift_manager
    false
  end
end
