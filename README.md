Allows you to use jupyterlab remotely with RTX 6000 without complex complex configuration:)
 
*Author: Kanta Yamaoka, Undergrad student of Osaka Prefecture University*


This is for:
- machine with Nvidia RTX A6000
	- Using image nvidia/cuda:11.7.1-base-ubuntu20.04
	- Please make sure the cuda version is compatible with your gpu node
- `docker` and `docker-compose` are configured

# Getting started

SSH into your gpu machine, and `./dc-start.sh`. This provides port number for the jupyterlab. 

Given that port number, open new terminal on your CLIENT, and use the following:

```
ssh -L 8888:127.0.0.1:{port_provided_by_above} {your_user_name}@{your_gpu_node_with_a6000}
```

Now, open your browser and go to:

```
http://localhost:8888/
```

Voila! Now you can access to gpu with jupyterlab from your own computer! 
**Enjoy RTX A6000!**

## Note
- I haven't added mapping from the local storage on your gpu node to docker container
	- I will add it soon!
- You can also modify `docker-compose.template.yaml` directly. 
- It chooses port on your gpu machine automatically for jupyterlab. 
- You can choose devices at `dc-start.sh`; please have a look at the script.


# Overview

- `dc-start.sh` starts and provides port
- `dc-stop.sh` stops docker container properly

```
├── README.md
├── dc-start.sh
├── dc-stop.sh
├── docker-compose.template.yaml
├── dockerfiles
│   └── min-pytorch
│       ├── Dockerfile
│       ├── req_ml_backend.txt
│       └── req_ml_tools.txt
```


# Acknowledgements
Many thanks to websites on the internet that helped making this tool!
(They are written in the source code.)