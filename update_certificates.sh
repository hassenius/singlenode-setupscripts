#!/usr/bin/env bash
while getopts ":d:c:k:" arg; do
    case "${arg}" in
      d)
        directory=${OPTARG}
        ;;
      c)
        certificate=${OPTARG}
        ;;
      k)
        key=${OPTARG}
        ;;
      \?)
        echo "Invalid option : -$OPTARG in commmand $0 $*" >&2
        exit 1
        ;;
      :)
        echo "Missing option argument for -$OPTARG in command $0 $*" >&2
        exit 1
        ;;
    esac
done

directory=${directory:-/u02/tic/stage/certs}
certificate=${certificate:-atapcdhictic01.crt}
key=${key:-atapcdhictic01.key}

kubectl -n kube-system delete cert icp-management-ingress-cert
kubectl -n kube-system delete secret icp-management-ingress-tls-secret
kubectl -n kube-system create secret tls icp-management-ingress-tls-secret --cert=${directory}/${certificate} --key=${directory}/${key}
kubectl -n kube-system delete pod $(kubectl -n kube-system get pod -o custom-columns=:metadata.name | grep icp-management-ingress)
