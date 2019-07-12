
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.4.0/kind-linux-amd64
chmod +x kubectl
chmod +x kind
# Install k8s clsuter
./kind create cluster --config config-helm.yaml
export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
# Install helm
curl -L https://git.io/get_helm.sh | bash
helm init
helm serve &
helm repo add local http://localhost:8879/charts
helm status
# Label the nodes
kubectl label nodes openstack-control-plane=enabled --all
kubectl label nodes openvswitch=enabled --all
kubectl label nodes openstack-compute-node=enabled --all
