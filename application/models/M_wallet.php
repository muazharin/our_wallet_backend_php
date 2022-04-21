<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_Wallet extends CI_Model
{
	public function get_wallet(){
		$id = $this->input->get('userId');
		$this->db->select('*');
		$this->db->from('wallet');
		$this->db->join('our_wallet','our_wallet.owWalletId = wallet.walletId', 'left');
		$this->db->where('wallet.walletIsActive', true);
		$this->db->where('our_wallet.owUserId', $id);
		$this->db->where('our_wallet.owIsUserActive', "1");
		$result = $this->db->get();
		if($result){
			$data = $result->result_array();
			$res = [
				'status' => true,
				'message' => 'Berhasil menampilkan data',
				'data' => $data,
			];
		}else{
			$res = [
				'status' => false,
				'message' => 'Gagal akses data',
			];
		}
		return $res;
	}
	public function create_wallet(){
		$userId = $this->input->post('userId');
		$walletName = $this->input->post('walletName');
		$walletColor = $this->input->post('walletColor');
		$data = [
			'walletName' => $walletName,
			'walletMoney' => 0,
			'walletColor' => $walletColor,
			'walletCreatedAt' => date('Y-m-d H:i:s'),
			'walletUpdatedAt' => date('Y-m-d H:i:s'),
			'walletIsActive' => true,
		];
		if($this->db->insert('wallet', $data)){
			$data1 = [
				'owWalletId' => $this->db->insert_id(),
				'owUserId' => $userId,
				'owIsUserActive' => 1,
				'owIsAdmin' => true,
				'owDate' => date('Y-m-d H:i:s'),
			];
			$this->db->insert('our_wallet', $data1);
			$res = [
				'status' => true,
				'message' => 'Berhasil membuat wallet baru!',
			];
			return $res;
		}else{
			$res = [
				'status' => false,
				'message' => 'Mohon maaf, terjadi kesalahan!',
			];
			return $res;
		}

	}
	public function update_wallet(){
		$id = $this->input->get('walletId');
		
		$this->db->where('walletId', $id);
		$result = $this->db->get('wallet');
		if($result->num_rows() < 1){
			$res = [
				'status' => false,
				'message' => 'Data tidak ditemukan',
			];
			return $res;
		}
		$userId = $this->input->post('userId');
		$walletName = $this->input->post('walletName');
		$walletColor = $this->input->post('walletColor');
		$data = [
			'walletName' => $walletName,
			'walletColor' => $walletColor,
			'walletUpdatedAt' => date('Y-m-d H:i:s'),
		];
		$this->db->where('walletId', $id);
		if($this->db->update('wallet', $data)){
			$res = [
				'status' => true,
				'message' => 'Wallet berhasil diupdate!',
			];
			return $res;
		}else{
			$res = [
				'status' => false,
				'message' => 'Mohon maaf, terjadi kesalahan!',
			];
			return $res;
		}
	}
	public function add_member_wallet(){
		$id = $this->input->get('owWalletId');
		$userId = $this->input->post('userId');
		$memberId = $this->input->post('memberId');

		$this->db->where('owWalletId', $id);
		$this->db->where('owUserId', $userId);
		$this->db->where('owIsAdmin', true);
		$result = $this->db->get('our_wallet')->num_rows();
		if($result < 1){
			$res = [
				'status' => false,
				'message' => 'Anda tidak memiliki hak akses admin!',
			];
			return $res;
		}

		$data = [
			"owWalletId" => $id,
			"owUserId" => $memberId,
			"owIsUserActive" => 0,
			"owIsAdmin" => false,
			"owDate" => date('Y-m-d H:i:s'),
		];
		
		$this->db->where('owWalletId', $id);
		$this->db->where('owUserId', $memberId);
		$cekUser = $this->db->get('our_wallet')->num_rows();
		if($cekUser > 0){	
			$this->db->where('owWalletId', $id);
			$this->db->where('owUserId', $memberId);
			if($this->db->update('our_wallet', $data)){
				$res = [
					'status' => true,
					'message' => 'Member berhasil ditambahkan',
				];
				return $res;
			}
		} else {
			if($this->db->insert('our_wallet', $data)){
				$res = [
					'status' => true,
					'message' => 'Member berhasil ditambahkan',
				];
				return $res;
			}
		}

	}
	public function get_user_to_wallet(){
		$id = $this->input->get('owWalletId');
		$keyword = $this->input->get('keyword');
		$list = '';
		$no = 1;
		$list_id = $this->get_member_of_wallet($id);
		$length = count($list_id['data']);
		foreach ($list_id['data'] as $l) {
			if($no == $length){
				$list.=$l['owUserId'];
			}else{
				$list.=$l['owUserId'].",";
			}
			$no++;
		}
		if($keyword == ""){
			$query = "SELECT * FROM users WHERE userId NOT IN (".$list.")";	
		}else{
			$query = "SELECT * FROM users 
			WHERE userId NOT IN (".$list.") AND 
			(userName LIKE '%".$keyword."%' 
			OR userEmail LIKE '%".$keyword."%' 
			OR userPhone LIKE '%".$keyword."%')";
		}
		$result = $this->db->query($query);
		if($result){
			$data = $result->result_array();
			$res = [
				'status' => true,
				'message' => 'Berhasil menampilkan data',
				'data' => $data,
			];
		}else{
			$res = [
				'status' => false,
				'message' => 'Gagal akses data',
			];
		}
		return $res;
		
	}
	public function get_member_of_wallet($id){
		$this->db->where('our_wallet.owIsUserActive',1);
		$this->db->where('our_wallet.owWalletId',$id);
		$this->db->join('users','users.userId = our_wallet.owUserId', 'left');
		$result = $this->db->get('our_wallet');
		if($result->num_rows() > 0){
			$data = $result->result_array();
			$res = [
				'status' => true,
				'message' => 'Berhasil menampilkan data',
				'data' => $data,
			];
		}else{
			$res = [
				'status' => false,
				'message' => 'Gagal akses data',
			];
		}
		return $res;
	}
	public function invited_check_wallet(){
		$id = $this->input->get('owUserId');
		$this->db->where('our_wallet.owIsUserActive', 0);
		$this->db->where('our_wallet.owUserId', $id);
		$this->db->join('wallet','wallet.walletId = our_wallet.owWalletId', 'left');
		$result = $this->db->get('our_wallet');
		if($result){
			$data = $result->result_array();
			$res = [
				'status' => true,
				'message' => 'Berhasil menampilkan data',
				'data' => $data,
			];
		}else{
			$res = [
				'status' => false,
				'message' => 'Gagal akses data',
			];
		}
		return $res;
	}
	public function confirm_member_wallet(){
		$id = $this->input->get('owId');
		$confirm = $this->input->post('confirm');
		if($confirm == "Yes"){ 
			$data['owIsUserActive']=1;
			$this->db->where('owId',$id);
			if($this->db->update('our_wallet', $data)){
				$res = [
					'status' => true,
					'message' => 'Selamat! Anda telah tergabung',
				];
			}else{
				$res = [
					'status' => false,
					'message' => 'Mohon maaf, telah terjadi kesalahan',
				];
			}
			return $res;
		}else{
			$this->db->where('owId',$id);
			if($this->db->delete('our_wallet')){
				$res = [
					'status' => true,
					'message' => 'Terima kasih atas konfirmasinya',
				];
			}else{
				$res = [
					'status' => false,
					'message' => 'Mohon maaf, telah terjadi kesalahan',
				];
			}
			return $res;
		}
	}
	public function remove_member_wallet(){
		$id = $this->input->get('owWalletId');
		$userId = $this->input->post('userId');
		$memberId = $this->input->post('memberId');

		$this->db->where('owWalletId', $id);
		$this->db->where('owUserId', $userId);
		$this->db->where('owIsAdmin', true);
		$result = $this->db->get('our_wallet')->num_rows();
		if($result < 1){
			$res = [
				'status' => false,
				'message' => 'Anda tidak memiliki hak akses admin!',
			];
			return $res;
		}
		$data = [
			"owIsUserActive" => 2,
			"owIsAdmin" => false,
			"owDate" => date('Y-m-d H:i:s'),
		];
		$this->db->where('owWalletId', $id);
		$this->db->where('owUserId', $memberId);
		if($this->db->update('our_wallet', $data)){
			$res = [
				'status' => true,
				'message' => 'Berhasil menghapus member',
			];
			return $res;
		}
	}
}