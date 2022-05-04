# Copyright (c) 2018-2019 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0
#

# Intel x86-64 settings

MACHINETYPE := q35
KERNELPARAMS :=
MACHINEACCELERATORS :=
CPUFEATURES := pmu=off

QEMUCMD := qemu-system-x86_64
# centos stream has decommissioned QEMUCMD and now only use the below one. Will
# replace all qemu configs with it for internal use
QEMUCENTOSCMD := qemu-kvm

# Firecracker binary name
FCCMD := firecracker
# Firecracker's jailer binary name
FCJAILERCMD := jailer

#ACRN binary name
ACRNCMD := acrn-dm
ACRNCTLCMD := acrnctl

# cloud-hypervisor binary name
CLHCMD := cloud-hypervisor

# TDX specific changes
CPUTDXFEATURES := "pmu=off,-kvm-steal-time"
KERNELTDXPARAMS := "force_tdx_guest\ tdx_disable_filter"
