//
//  FirstInstallViewController.swift
//  tv-ios
//
//  Created by Erinson Villarroel on 26/09/2019.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import UIKit

final class FirstInstallViewController: UIViewController, UITableViewDelegate, Networked, MainCoordinated,
LoginCoordinated, ProfileManagementAuthenticating  {
    let networkIdentifier = NetworkIdentifier()

    var networkController: NetworkController?
    weak var mainCoordinator: MainFlowCoordinator?
    weak var loginCoordinator: LoginFlowCoordinator?
    
    var isClientAuthenticated: Bool {
        return networkController?.isClientAuthenticated ?? false
    }
    var profile: Profile?
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }

    private let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.profile = profile

        viewModel.reloadData = { [weak self] in
            self?.tableView?.reloadData()
        }

        viewModel.confirming = { [weak self] params in
            self?.confirmInstall(params: params)
        }

        viewModel.showAlert = { [weak self] section in
            self?.showAlert(section: section)
        }

        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.sectionHeaderHeight = 50
        tableView?.separatorStyle = .none
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.register(NameProfileCell.nib, forCellReuseIdentifier: NameProfileCell.identifier)
        tableView?.register(ProfilePin.nib, forCellReuseIdentifier: ProfilePin.identifier)
        tableView?.register(RestrictProfileAccess.nib, forCellReuseIdentifier: RestrictProfileAccess.identifier)
        tableView?.register(PersonalRecommendations.nib, forCellReuseIdentifier: PersonalRecommendations.identifier)
        tableView?.register(ReplayFunction.nib, forCellReuseIdentifier: ReplayFunction.identifier)
        tableView?.register(FinishedCell.nib, forCellReuseIdentifier: FinishedCell.identifier)
        tableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }
}

extension FirstInstallViewController {
    // TODO: Erinson - extract inner functions to private ones
    // swiftlint:disable function_body_length
    func confirmInstall(params: [HeaderType: Any]) {
        let dispatchGroup = DispatchGroup()
        var successed = true

        func updateNickname(nickname: Any?) {
            guard let nickname = nickname as? String else {
                return
            }
            dispatchGroup.enter()
            networkController?.updateProfileNickname(withIdentifier: self.networkIdentifier, nickname: nickname, completion: { result in
                dispatchGroup.leave()
                do {
                    let data = try result.get()
                    dlog("Update nickname \(data)")
                } catch {
                    successed = false
                    dlog(error)
                }
            })
        }

        func updatePinCode(pinCode: Any?) {
            guard let pinCode = pinCode as? String else {
                return
            }
            dispatchGroup.enter()
            networkController?.updateProfilePinCode(withIdentifier: self.networkIdentifier, pinCode: pinCode, completion: { result in
                dispatchGroup.leave()
                do {
                    let data = try result.get()
                    dlog("Update pinCode \(data)")
                } catch {
                    successed = false
                    dlog(error)
                }
            })
        }

        func updateProtected(protected: Any?) {
            guard let protected = protected as? Bool else {
                return
            }
            dispatchGroup.enter()
            networkController?.updateProfileProtected(withIdentifier: self.networkIdentifier, protected: protected, completion: { result in
                dispatchGroup.leave()
                do {
                    let data = try result.get()
                    dlog("Update protected \(data)")
                } catch {
                    successed = false
                    dlog(error)
                }
            })
        }

        func updateRecommendations(personalized: Any?) {
            guard let personalized = personalized as? Bool else {
                return
            }
            let profileId = networkController!.profileId!
            let body = BodyUpdateRecommendation(profileId: profileId, personalized: personalized)
            let bodyFile = "UpdateProfile.xml"
            dispatchGroup.enter()
            networkController?.fetchValue(withIdentifier: self.networkIdentifier,
                                          url: QuicklineEndpoint.baseTraxisUrl,
                                          body: body, bodyTemplateFile: bodyFile,
                                          isProfile: false,
                                          completion: { (result:  Result<ProfileUpdate>) in
                dispatchGroup.leave()
                do {
                    let data = try result.get()
                    dlog("Update recommendations \(data)")
                } catch {
                    successed = false
                    dlog(error)
                }
            })
        }

        func touchInstallationDone() {
            let profileId = networkController!.profileId!
            let body = BodyAddNamedProperty(profileId: profileId, property: "ATP.FirstInstallationDone", value: true)
            let bodyFile = "AddNamedProperties.xml"
            networkController?.fetchValue(withIdentifier: self.networkIdentifier,
                                          url: QuicklineEndpoint.baseTraxisUrl,
                                          body: body,
                                          bodyTemplateFile: bodyFile,
                                          isProfile: false,
                                          completion: { [weak self] (result:  Result<DataEmpty>) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.stopActivityIndicator()
                do {
                    let successed = try result.get()
                    dlog("succeed: \(successed)")
                    dlog("Touch installation done")
                    strongSelf.loginCoordinator?.loginViewControllerDidFinishFirstInstall(strongSelf)
                } catch {
                    dlog(error)
                }
            })
        }

        func turnReplay(isOn: Any?) {
            guard let isOn = isOn as? Bool else {
                return
            }
            isOn ? turnReplayOn() : turnReplayOff()
        }

        func turnReplayOn() {
            func channelIds(channels: [Channel]) -> [String] {
                return channels.map { $0.id }
            }

            func addMultipleChannelsToRecordingOptInChannels(channels: Channels) {
                let profileId = networkController!.profileId!
                let ids = channelIds(channels: channels.channels)
                let body = BodyAddMultipleChannelsRecording(profileId: profileId, channels: ids)
                let bodyFile = "AddMultipleChannelsToRecordingOptInChannelList.xml"
                networkController?.fetchValue(withIdentifier: self.networkIdentifier,
                                              url: QuicklineEndpoint.baseTraxisUrl,
                                              body: body,
                                              bodyTemplateFile: bodyFile,
                                              completion: { (result: Result<AddRecommendations>) in
                    dispatchGroup.leave()
                    do {
                        let data = try result.get()
                        dlog("Add channels to recordings opt \(data)")
                    } catch {
                        successed = false
                        dlog(error)
                    }
                })
            }

            func fetchChannels() {
                dispatchGroup.enter()

                let profileId = networkController!.profileId!
                let body =  BodyChannels(profileId: profileId, isAdultExcluded: true, isMyChannelExcluded: false,
                                         isBlockedExcluded: true, isOnlyViewableOnCpe: true)
                let bodyFile = "Channels.xml"
                networkController?.fetchCachableValue(withIdentifier: self.networkIdentifier,
                                                      url: QuicklineEndpoint.baseTraxisUrl,
                                                      body: body,
                                                      bodyTemplateFile: bodyFile) { (result: Result<Channels>) in
                    do {
                        let data = try result.get()
                        addMultipleChannelsToRecordingOptInChannels(channels: data)
                    } catch {
                        dispatchGroup.leave()
                        successed = false
                        dlog(error)
                    }
                }
            }

            fetchChannels()
        }

        func turnReplayOff() {
            func deleteReplayChannels() {
                dispatchGroup.enter()

                let profileId = networkController!.profileId!
                let body = BodyRecordings(profileId: profileId)
                let bodyFile = "DeleteAllChannelsFromRecordingOptInChannelList.xml"
                networkController?.fetchValue(withIdentifier: self.networkIdentifier,
                                              url: QuicklineEndpoint.baseTraxisUrl,
                                              body: body,
                                              bodyTemplateFile: bodyFile,
                                              completion: { (result: Result<DataEmpty>) in
                    dispatchGroup.leave()
                    do {
                        let data = try result.get()
                        dlog("Delete replay channels \(data)")
                    } catch {
                        successed = false
                        dlog(error)
                    }
                })
            }

            func getCustomer() {
                dispatchGroup.enter()

                guard let profileId = networkController?.profileId else { return }
                let memoryParameters = RecordingsFreeSpaceParameters(profileId: profileId)
                networkController?.fetchValue(withIdentifier: self.networkIdentifier, url: QuicklineEndpoint.baseTraxisUrl,
                                              body: memoryParameters.body,
                                              bodyTemplateFile: memoryParameters.bodyFile) { (result: Result<Customer>) in
                    do {
                        let data = try result.get()
                        clearRecordings(customer: data)
                        dlog("Get customer \(data)")
                    } catch {
                        dispatchGroup.leave()
                        successed = false
                        dlog(error)
                    }
                }
            }

            func clearRecordings(customer: Customer) {
                let body = BodyClearRecordings(customerId: customer.id, crmId: customer.crmId)
                let bodyTemplateFile = "ClearRecordingOptInDate.xml"
                networkController?.fetchValue(withIdentifier: self.networkIdentifier,
                                              url: QuicklineEndpoint.baseTraxisUrl,
                                              body: body,
                                              bodyTemplateFile: bodyTemplateFile) { (result: Result<DataEmpty>) in
                    dispatchGroup.leave()
                    do {
                        let data = try result.get()
                        dlog("Clear recordings \(data)")
                    } catch {
                        successed = false
                        dlog(error)
                    }
                }
            }

            getCustomer()
            deleteReplayChannels()
        }

        guard let pinCode = params[.pinProfile] as? String else {
            return
        }

        startActivityIndicator()

        authenticateManagementProfile(pin: pinCode) { [weak self] result in
            do {
                let data = try result.get()
                dlog("Get management token \(data)")
                updateNickname(nickname: params[.nameProfile])
                updatePinCode(pinCode: params[.pinProfile])
                updateProtected(protected: params[.restrictProfile])
                updateRecommendations(personalized: params[.personalRecommendations])
                turnReplay(isOn: params[.replay])
                dispatchGroup.notify(queue: .main) {
                    dlog("Finishing installation")
                    touchInstallationDone()
                }
            } catch {
                self?.stopActivityIndicator()
                dlog(error)
            }
        }
    }

    func showAlert(section: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.mainCoordinator?.showAlert(viewController: self!,
                                             for: "Replay nicht aktivieren?",
                                             message: "Du kannst TV Sendungen nur zeitversetz anschauen, wenn Replay aktiviert ist.",
                                             cancelTitle: "Weiter ohne replay",
                                             actionTitle: "Replay aktivieren",
                                             cancelCompletion: {
                self?.viewModel.toggleNext(section: section, value: 2)
            }, actionCompletion: {
                self?.viewModel.toggleReplay(on: true)
            })
        }
    }
}

extension FirstInstallViewController {
    private func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }

    private func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}
