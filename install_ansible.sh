apt install python3-pip git sshpass python3.11-venv
git clone https://github.com/PrismaPhotonics/linux-infra.git


# Create a virtual environment named 'ansible-env'
python3 -m venv ansible-env

# Activate the virtual environment
source ansible-env/bin/activate

# Upgrade pip in the virtual environment
pip install --upgrade pip

# Install Ansible using pip
pip install ansible

# Verify the installation
ansible --version

echo "Ansible installation is complete! To work in this environment, run: source ansible-env/bin/activate"

source /root/ansible-env/bin/activate 

# Check if ansible-galaxy command exists.
if ! command -v ansible-galaxy &> /dev/null; then
    echo "Error: ansible-galaxy command not found."
    echo "Make sure Ansible is installed and your PATH is configured correctly."
    echo "For example, if using a virtual environment, run 'source ansible-env/bin/activate'"
    exit 1
fi

# Define an array of collections in the format namespace.collection:version.
collections=(
    "community.kubernetes:2.0.1"
    "amazon.aws:8.2.1"
    "ansible.netcommon:6.1.3"
    "ansible.posix:1.6.2"
    "ansible.utils:4.1.0"
    "ansible.windows:2.5.0"
    "arista.eos:9.0.0"
    "awx.awx:24.6.1"
    "azure.azcollection:2.7.0"
    "check_point.mgmt:5.2.3"
    "chocolatey.chocolatey:1.5.3"
    "cisco.aci:2.10.1"
    "cisco.asa:5.0.1"
    "cisco.dnac:6.25.0"
    "cisco.intersight:2.0.20"
    "cisco.ios:8.0.0"
    "cisco.iosxr:9.0.0"
    "cisco.ise:2.9.6"
    "cisco.meraki:2.18.3"
    "cisco.mso:2.9.0"
    "cisco.nxos:8.1.0"
    "cisco.ucs:1.14.0"
    "cloud.common:3.0.0"
    "cloudscale_ch.cloud:2.4.0"
    "community.aws:8.0.0"
    "community.ciscosmb:1.0.9"
    "community.crypto:2.22.3"
    "community.digitalocean:1.27.0"
    "community.dns:3.1.0"
    "community.docker:3.13.3"
    "community.general:9.5.2"
    "community.grafana:1.9.1"
    "community.hashi_vault:6.2.0"
    "community.hrobot:2.0.2"
    "community.library_inventory_filtering_v1:1.0.2"
    "community.libvirt:1.3.0"
    "community.mongodb:1.7.8"
    "community.mysql:3.11.0"
    "community.network:5.1.0"
    "community.okd:3.0.1"
    "community.postgresql:3.9.0"
    "community.proxysql:1.6.0"
    "community.rabbitmq:1.3.0"
    "community.routeros:2.20.0"
    "community.sap_libs:1.4.2"
    "community.sops:1.9.1"
    "community.vmware:4.8.1"
    "community.windows:2.3.0"
    "community.zabbix:2.5.1"
    "containers.podman:1.16.2"
    "cyberark.conjur:1.3.1"
    "cyberark.pas:1.0.30"
    "dellemc.enterprise_sonic:2.5.1"
    "dellemc.openmanage:9.9.0"
    "dellemc.powerflex:2.5.0"
    "dellemc.unity:2.0.0"
    "f5networks.f5_modules:1.32.1"
    "fortinet.fortimanager:2.8.2"
    "fortinet.fortios:2.3.8"
    "frr.frr:2.0.2"
    "google.cloud:1.4.1"
    "grafana.grafana:5.6.0"
    "hetzner.hcloud:3.1.1"
    "ibm.qradar:3.0.0"
    "ibm.spectrum_virtualize:2.0.0"
    "ibm.storage_virtualize:2.5.0"
    "ieisystem.inmanage:2.0.0"
    "infinidat.infinibox:1.4.5"
    "infoblox.nios_modules:1.7.1"
    "inspur.ispim:2.2.3"
    "inspur.sm:2.3.0"
    "junipernetworks.junos:8.0.0"
    "kaytus.ksmanage:1.2.2"
    "kubernetes.core:3.2.0"
    "kubevirt.core:1.5.0"
    "lowlydba.sqlserver:2.3.4"
    "microsoft.ad:1.7.1"
    "netapp.cloudmanager:21.24.0"
    "netapp.ontap:22.13.0"
    "netapp.storagegrid:21.13.0"
    "netapp_eseries.santricity:1.4.1"
    "netbox.netbox:3.20.0"
    "ngine_io.cloudstack:2.5.0"
    "ngine_io.exoscale:1.1.0"
    "openstack.cloud:2.3.0"
    "openvswitch.openvswitch:2.1.1"
    "ovirt.ovirt:3.2.0"
    "purestorage.flasharray:1.32.0"
    "purestorage.flashblade:1.19.1"
    "sensu.sensu_go:1.14.0"
    "splunk.es:3.0.0"
    "t_systems_mms.icinga_director:2.0.1"
    "telekom_mms.icinga_director:2.2.1"
    "theforeman.foreman:4.2.0"
    "vmware.vmware:1.7.1"
    "vmware.vmware_rest:3.2.0"
    "vultr.cloud:1.13.0"
    "vyos.vyos:4.1.0"
    "wti.remote:1.0.10"
)

# Loop through each collection and install it.
for coll in "${collections[@]}"; do
    echo "Installing ${coll}..."
    ansible-galaxy collection install "$coll"
done

echo "All collections have been installed."


cd linux-infra/ansible

ansible-playbook playbooks/setup_hypervisor.yml -e @../sites_manifests/shaked_version.yml 