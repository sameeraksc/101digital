#!/bin/bash

IMAGE_NAME="sameeraksc/hellowhale:${BUILD_NUMBER}"
docker build . -t $IMAGE_NAME
docker login -u sameeraksc -p newpin123
docker push $IMAGE_NAME


NAMESPACE=backend-services
SERVICENAME=hellowhale

cp -r /home/centos/kubernetes $WORKSPACE/
sed -i 's/SERVICENAME/'$SERVICENAME'/g' $WORKSPACE/kubernetes/deployment.yaml
sed -i 's/NAMESPACE/'$NAMESPACE'/g' $WORKSPACE/kubernetes/deployment.yaml
sed -i 's+IMAGENAME+'$IMAGE_NAME'+g' $WORKSPACE/kubernetes/deployment.yaml
echo "sed -i 's+IMAGENAME+'$IMAGE_NAME'+g' $WORKSPACE/kubernetes/deployment.yaml"
sed -i 's/SERVICENAME/'$SERVICENAME'/g' $WORKSPACE/kubernetes/service.yaml
sed -i 's/NAMESPACE/'$NAMESPACE'/g' $WORKSPACE/kubernetes/service.yaml
sed -i 's/NAMESPACE/'$NAMESPACE'/g' $WORKSPACE/kubernetes/pv-pvs.yaml
sed -i 's/NAMESPACE/'$NAMESPACE'/g' $WORKSPACE/kubernetes/ns.yaml

KUBE_DEPLOYMENT_FILE=$WORKSPACE/kubernetes/deployment.yaml
KUBE_SERVICE_FILE=$WORKSPACE/kubernetes/service.yaml

kubectl apply -f $WORKSPACE/kubernetes/ns.yaml
kubectl apply -f $WORKSPACE/kubernetes/pv-pvs.yaml

#kubernetes image setting
echo "kubectl get service ${SERVICENAME}-service -n ${NAMESPACE}"
echo ""
kubectl get service ${SERVICENAME}-service -n ${NAMESPACE}

if [ $? -ne 0 ]
then
    #if service not
    echo "KUBE SERVICE IS NOT THERE"
    echo "kubectl get deployment ${SERVICENAME}-deployment -o wide -n ${NAMESPACE}"
	kubectl get deployment ${SERVICENAME}-deployment -o wide -n ${NAMESPACE}
	if [ $? -ne 0 ]
	then
	    echo "KUBE SERVICE AND DEPLOYMENT IS NOT THERE"
	    kubectl create -f $KUBE_DEPLOYMENT_FILE
		if [ $? -ne 0 ]
		then
			echo "Kubernetes ${SERVICENAME}-depolment failed !!"
			exit 1
		fi
		kubectl create -f $KUBE_SERVICE_FILE
		if [ $? -ne 0 ]
		then
			echo "Kubernetes ${SERVICENAME}-service failed !!}"
			exit 1
		fi
    else
        echo "KUBE SERVICE IS NOT THERE BUT DEPLOYMENT IS THERE"
        echo "kubectl set image deployment/${SERVICENAME}-deployment ${SERVICENAME}=$imagename -n ${NAMESPACE} --record"
		kubectl set image deployment/${SERVICENAME}-deployment ${SERVICENAME}=$IMAGE_NAME -n ${NAMESPACE} --record
		if [ $? -ne 0 ]
		then
			echo "Kubernetes ${SERVICENAME}-deployment set image $IMAGE_NAME failed !!}"
			exit 1
		fi
		kubectl rollout status deployment/${SERVICENAME}-deployment -n ${NAMESPACE}
		echo ""
		kubectl create -f $KUBE_SERVICE_FILE
		if [ $? -ne 0 ]
		then
			echo "Kubernetes ${SERVICENAME}-service failed !!}"
			exit 1
		fi
	fi
else
    echo "KUBE SERVICE IS THERE"
	echo "kubectl get deployment ${SERVICENAME}-deployment -o wide -n ${NAMESPACE}"
	kubectl get deployment ${SERVICENAME}-deployment -o wide -n ${NAMESPACE}
	if [ $? -ne 0 ]
	then
	    echo "KUBE DEPLOYMENT IS NOT THERE BUT SERVICE IS THERE"
	    kubectl create -f $KUBE_DEPLOYMENT_FILE
		if [ $? -ne 0 ]
		then
			echo "Kubernetes ${SERVICENAME}-depolment failed !!"
			exit 1
		fi
	else
	    echo "KUBE DEPLOYMENT AND SERVICE IS THERE"
		echo "kubectl set image deployment/${SERVICENAME}-deployment ${SERVICENAME}=$IMAGE_NAME -n ${NAMESPACE} --record"
		kubectl set image deployment/${SERVICENAME}-deployment ${SERVICENAME}=$IMAGE_NAME -n ${NAMESPACE} --record
		if [ $? -ne 0 ]
		then
			echo "Kubernetes ${SERVICENAME}-deployment set image $imagename failed !!}"
			exit 1
		fi
		kubectl rollout status deployment/${SERVICENAME}-deployment -n ${NAMESPACE}
	fi
fi

